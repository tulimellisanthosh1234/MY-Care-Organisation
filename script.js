function openModal() {
  document.getElementById("loginModal").style.display = "block";
}

function closeModal() {
  document.getElementById("loginModal").style.display = "none";
}

function openRegisterModal() {
  document.getElementById("registerModal").style.display = "block";
}

function closeRegisterModal() {
  document.getElementById("registerModal").style.display = "none";
}

function makeDraggable(el) {
      let isDown = false, offsetX, offsetY;
      el.addEventListener('mousedown', e => {
        isDown = true;
        offsetX = e.clientX - el.getBoundingClientRect().left;
        offsetY = e.clientY - el.getBoundingClientRect().top;
      });
      document.addEventListener('mousemove', e => {
        if (!isDown) return;
        el.style.left = e.clientX - offsetX + 'px';
        el.style.top  = e.clientY - offsetY + 'px';
      });
      document.addEventListener('mouseup', () => isDown = false);
    }

    window.addEventListener('load', () => {
      makeDraggable(document.getElementById('loginBox'));
      makeDraggable(document.getElementById('registerBox'));
    });

// Close modals when clicking outside
window.onclick = function (event) {
  const loginModal = document.getElementById("loginModal");
  const registerModal = document.getElementById("registerModal");

  if (event.target === loginModal) loginModal.style.display = "none";
  if (event.target === registerModal) registerModal.style.display = "none";
};

// Validate form inputs and switch to Sign In
document.getElementById("registrationForm").addEventListener("submit", function (e) {
  e.preventDefault();

  const pwd = document.getElementById("password").value;
  const confirm = document.getElementById("confirmPassword").value;
  const phone = document.getElementById("phone").value;
  const email = document.getElementById("email").value;

  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  const phoneRegex = /^\d{10}$/;
  const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,12}$/;

  if (!emailRegex.test(email)) {
    alert("Please enter a valid email address.");
    return;
  }

  if (!phoneRegex.test(phone)) {
    alert("Please enter a valid 10-digit mobile number.");
    return;
  }

  if (!passwordRegex.test(pwd)) {
    alert("Password must be 8–12 characters long and include uppercase, lowercase, number, and special character.");
    return;
  }

  if (pwd !== confirm) {
    alert("Passwords do not match!");
    return;
  }

  closeRegisterModal();
  openModal();
  document.getElementById("registrationForm").reset();
});
