import mysql.connector
from flask import Flask, render_template, request, redirect, url_for, session

app = Flask(__name__)
app.secret_key = "super_secret_demo_key"

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="CAS!2345",
    database="hotel_data",
    port=3306
)

def get_cursor():
    return db.cursor(dictionary=True)

#-----room-----
@app.route("/rooms")
def rooms_list():
    role = session.get("role")   # guest / employee / None
    sort = request.args.get("sort")  # optional sort field

    cur = get_cursor()

    base_query = """
        SELECT 
            r.room_id,
            r.room_number,
            r.room_type,
            r.floor,
            r.is_smoking,
            r.status,
            r.base_rate,
            r.capacity,
            b.building_name,
            w.wing_name
        FROM room r
        JOIN building b ON r.building_id = b.building_id
        JOIN wing w ON r.wing_id = w.wing_id
    """

    # Guest can only see available rooms
    if role == "guest":
        base_query += " WHERE r.status = 'Available' "

    # Sorting
    valid_sorts = {
        "price": "r.base_rate",
        "status": "r.status",
        "capacity": "r.capacity",
        "type": "r.room_type"
    }

    if sort in valid_sorts:
        base_query += f" ORDER BY {valid_sorts[sort]}"

    else:
        base_query += " ORDER BY r.room_id"

    cur.execute(base_query)
    rooms = cur.fetchall()

    return render_template("rooms.html", rooms=rooms, role=role)


#-----reservation-----Guest make new reservation
@app.route("/reservations/new", methods=["GET", "POST"])
def reservations_new():
    role = session.get("role")
    party_id = session.get("party_id")  
    

    if role != "customer":
        return redirect(url_for("login"))

    cur = get_cursor()

    if request.method == "POST":
        start_date = request.form.get("start_date")
        end_date = request.form.get("end_date")
        num_guests = request.form.get("num_guests", 1)

        cur.execute("""
            INSERT INTO reservation_request
                (party_id, start_date, end_date, number_of_guests, status)
            VALUES (%s, %s, %s, %s, 'Future')
        """, (party_id, start_date, end_date, num_guests))

        db.commit()

        return redirect(url_for("reservations_list"))
    
    return render_template("reservations_new.html")


#----Guest — view confirmed reservations----
@app.route("/reservations/my")
def reservations_list():
    role = session.get("role")
    party_id = session.get("party_id")

    if role != "customer":
        return redirect(url_for("login"))

    cur = get_cursor()

    cur.execute("""
        SELECT rr.reservation_id,
               rr.start_date,
               rr.end_date,
               r.room_number,
               r.room_type,
               r.base_rate,
                rr.num_guest,
                rr.status
        FROM reservation_request rr
        LEFT JOIN room_assignment ra 
               ON rr.reservation_id = ra.reservation_id
        LEFT JOIN room r
               ON ra.room_id = r.room_id
        WHERE rr.party_id = %s 
          AND rr.status = 'Confirmed'
        ORDER BY rr.start_date DESC
    """, (party_id,))

    reservations = cur.fetchall()

    return render_template("reservations_list.html", reservations=reservations)


#----Employee - view pending requests----
@app.route("/reservations/pending")
def reservations_pending():
    if session.get("role") != "employee":
        return redirect(url_for("login"))

    cur = get_cursor()

    cur.execute("""
        SELECT rr.reservation_id,
               rr.start_date,
               rr.end_date,
               rr.num_guest,
               rr.status,
               p.party_type,
               p.customer_id,
               c.first_name,
               c.last_name
        FROM reservation_request rr
        LEFT JOIN party p ON rr.party_id = p.party_id
        LEFT JOIN customer c ON p.customer_id = c.customer_id
        WHERE rr.status = 'Future'
        ORDER BY rr.start_date
    """)

    requests = cur.fetchall()

    return render_template("reservations_pending.html", requests=requests)

#----Employee — see assignments----
@app.route("/reservations/<int:res_id>/assign", methods=["GET", "POST"])
def reservation_assign(res_id):
    if session.get("role") != "employee":
        return redirect(url_for("login"))

    cur = get_cursor()

    # GET: show rooms and form
    if request.method == "GET":
        cur.execute("SELECT * FROM reservation_request WHERE reservation_id=%s", (res_id,))
        req = cur.fetchone()

        cur.execute("SELECT room_id, room_number, room_type FROM room WHERE status='Available'")
        rooms = cur.fetchall()

        return render_template("reservation_assign.html", req=req, rooms=rooms)

    # POST: assign the room
    room_id = request.form.get("room_id")

    # insert into room_assignment
    cur.execute("""
        INSERT INTO room_assignment (reservation_id, room_id, assigned_date)
        VALUES (%s, %s, CURDATE())
    """, (res_id, room_id))

    # update reservation_request
    cur.execute("""
        UPDATE reservation_request
        SET status='Confirmed'
        WHERE reservation_id=%s
    """, (res_id,))

    # update room status
    cur.execute("""
        UPDATE room SET status='Occupied' WHERE room_id=%s
    """, (room_id,))

    db.commit()

    return redirect(url_for("reservations_pending"))


#----EVENTS-----
#Guest — see own events
@app.route("/events/my")
def events_my():
    if session.get("role") != "customer":
        return redirect(url_for("login"))

    party_id = session.get("party_id")
    cur = get_cursor()

    cur.execute("""
            SELECT 
                e.event_id,
                e.event_name,
                e.event_duration,
                e.est_attendance,
                e.est_guest_count,
                f.facility_id
            FROM event e
            LEFT JOIN event_facility_use efu 
                ON e.event_id = efu.event_id
            LEFT JOIN facility f 
                ON efu.facility_id = f.facility_id
            WHERE e.host_party_id = %s
            ORDER BY e.event_id DESC;
    """, (party_id,))

    events = cur.fetchall()
    return render_template("events_my.html", events=events)


#----Employee — view all events with full JOIN----
@app.route("/events/all")
def events_all():
    if session.get("role") != "employee":
        return redirect(url_for("login"))

    cur = get_cursor()

    # --- 1. Full event info (host, billing, counts) ---
    cur.execute("""
        SELECT 
            e.event_id,
            e.event_name,
            e.event_duration,
            e.est_attendance,
            e.est_guest_count,
            p.party_type,
            c.first_name,
            c.last_name,
            o.organization_name,
            b.status AS billing_status
        FROM event e
        LEFT JOIN party p ON e.host_party_id = p.party_id
        LEFT JOIN customer c ON p.customer_id = c.customer_id
        LEFT JOIN organization o ON p.organization_id = o.organization_id
        LEFT JOIN billing_account b ON e.billing_account_id = b.billing_account_id
        ORDER BY e.event_id DESC;
    """)

    events = cur.fetchall()

    # --- 2. Rooms occupied today ---
    cur.execute("""
        SELECT room_id 
        FROM event_room_use 
        WHERE date = CURDATE();
    """)

    occupied_rooms_rows = cur.fetchall()
    occupied_rooms = {row["room_id"] for row in occupied_rooms_rows}

    # --- 3. Facilities occupied today ---
    cur.execute("""
        SELECT facility_id 
        FROM event_facility_use 
        WHERE date = CURDATE();
    """)

    occupied_fac_rows = cur.fetchall()
    occupied_facilities = {row["facility_id"] for row in occupied_fac_rows}

    # --- 4. Available rooms (all except occupied) ---
    cur.execute("SELECT room_id, room_number FROM room ORDER BY room_id")
    all_rooms = cur.fetchall()

    available_rooms = [r for r in all_rooms if r["room_id"] not in occupied_rooms]

    # --- 5. Available facilities ---
    cur.execute("SELECT facility_id FROM facility ORDER BY facility_id")
    all_facilities = cur.fetchall()

    available_facilities = [f for f in all_facilities if f["facility_id"] not in occupied_facilities]

    return render_template(
        "events_all.html",
        events=events,
        occupied_rooms=occupied_rooms,
        occupied_facilities=occupied_facilities,
        available_rooms=available_rooms,
        available_facilities=available_facilities
    )


#----BILLING----

#----Guest — see own billing----
@app.route("/billing/my")
def billing_my():
    # 必须是 guest
    if session.get("role") != "customer":
        return redirect(url_for("login"))

    party_id = session.get("party_id")
    customer_id = session.get("customer_id")

    cur = get_cursor()


    cur.execute("""
        SELECT *
        FROM billing_account
        WHERE party_id = %s
        LIMIT 1
    """, (party_id,))

    account = cur.fetchone()


    if not account:
        return render_template("billing_my.html",
                               account=None,
                               charges=[])

    billing_account_id = account["billing_account_id"]


    cur.execute("""
            SELECT 
                c.charge_id,
                c.total_amount,
                c.posted_at,
                st.description AS service_desc
            FROM charge c
            LEFT JOIN service_usage su 
                ON c.service_usage_id = su.service_usage_id
            LEFT JOIN service_type st
                ON su.service_id = st.service_id
            WHERE c.customer_id = %s
            ORDER BY c.posted_at DESC;
    """, (customer_id,))

    charges = cur.fetchall()

    return render_template("billing_my.html",
                           account=account,
                           charges=charges)

#----Employee — see all billing accounts----
@app.route("/billing/all")
def billing_all():
    if session.get("role") != "employee":
        return redirect(url_for("login"))

    cur = get_cursor()

    cur.execute("""
        SELECT 
            b.billing_account_id,
            b.party_id,
            p.party_type,
            COALESCE(SUM(ca.amount), 0) AS total_charges
        FROM billing_account b
        LEFT JOIN charge_allocation ca 
               ON b.billing_account_id = ca.billing_account_id
        LEFT JOIN party p 
               ON b.party_id = p.party_id
        GROUP BY b.billing_account_id, b.party_id, p.party_type
        ORDER BY b.billing_account_id ASC;
    """)

    accounts = cur.fetchall()

    return render_template("billing_all.html", accounts=accounts)

@app.route("/billing/detail/<int:acc_id>")
def billing_detail(acc_id):
    if session.get("role") != "employee":
        return redirect(url_for("login"))

    cur = get_cursor()

    # Get account information
    cur.execute("""
        SELECT b.billing_account_id, p.party_type, p.party_id
        FROM billing_account b
        JOIN party p ON b.party_id = p.party_id
        WHERE b.billing_account_id = %s
    """, (acc_id,))
    account = cur.fetchone()

    if not account:
        return f"Billing account {acc_id} not found", 404

    # Get charges associated with this billing account
    cur.execute("""
        SELECT 
            c.charge_id,
            c.total_amount,
            c.posted_at,
            ca.amount AS allocated_amount,
            ca.responsible_percent,
            c.reservation_id,
            c.customer_id,
            c.service_usage_id,
            c.facility_id
        FROM charge c
        JOIN charge_allocation ca ON c.charge_id = ca.charge_id
        WHERE ca.billing_account_id = %s
        ORDER BY c.posted_at DESC
    """, (acc_id,))
    charges = cur.fetchall()

    return render_template("billing_detail.html", account=account, charges=charges)


#----Login----
@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        user = request.form.get("user")

        if user == "guest":
            session["role"] = "customer"
            session["name"] = "John Doe"
            session["party_id"] = 1
            return redirect(url_for("index"))

        elif user == "employee":
            session["role"] = "employee"
            session["name"] = "Hotel Staff"
            return redirect(url_for("index"))

    return render_template("login.html")

@app.route("/debug_session")
def debug_session():
    return dict(session)



@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("index"))

@app.route("/")
def index():
    return render_template("index.html")

if __name__ == "__main__":
    app.run(debug=True)
