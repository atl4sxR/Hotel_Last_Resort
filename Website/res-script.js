const customerTab = document.getElementById("customerTab");
const employeeTab = document.getElementById("employeeTab");
const customerForm = document.getElementById("customerForm");
const employeeForm = document.getElementById("employeeForm");

customerTab.addEventListener("click", () => {
  customerTab.classList.add("active");
  employeeTab.classList.remove("active");
  customerForm.classList.add("active-form");
  employeeForm.classList.remove("active-form");
});

employeeTab.addEventListener("click", () => {
  employeeTab.classList.add("active");
  customerTab.classList.remove("active");
  employeeForm.classList.add("active-form");
  customerForm.classList.remove("active-form");
});
