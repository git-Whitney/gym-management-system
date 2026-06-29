// ================= PASSWORD TOGGLE =================
function togglePassword(fieldId, icon) {
    const input = document.getElementById(fieldId);

    if (!input) return;

    if (input.type === "password") {
        input.type = "text";
        icon.textContent = "🙈";
    } else {
        input.type = "password";
        icon.textContent = "👁️";
    }
}

document.addEventListener("DOMContentLoaded", () => {

    // ================= REGEX PATTERNS =================
    const regPattern = /^[A-Za-z]\d{2}\/\d{5}\/\d{2}$/;
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const phonePattern =  /^(07|01)\d{8}$/;
    const namePattern = /^[A-Za-z\s]+$/;

    // ================= IMPROVED PASSWORD REGEX =================
    // At least 8 characters with uppercase, lowercase, number, and special character
    const strongPasswordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

    // ================= HELPER FUNCTIONS =================
    function showError(input, message, errorId) {
        input.classList.add("input-error");
        const errorElement = document.getElementById(errorId);
        if (errorElement) {
            errorElement.textContent = message;
            errorElement.style.color = '#dc3545';
        }
    }

    function clearError(input, errorId) {
        input.classList.remove("input-error");
        const errorElement = document.getElementById(errorId);
        if (errorElement) {
            errorElement.textContent = "";
        }
    }

    function showSuccess(input, message, errorId) {
        input.classList.remove("input-error");
        input.classList.add("input-success");
        const errorElement = document.getElementById(errorId);
        if (errorElement) {
            errorElement.textContent = message;
            errorElement.style.color = '#28a745';
        }
    }

    // ================= PASSWORD STRENGTH INDICATOR =================
    function getPasswordStrength(password) {
        const hasUpperCase = /[A-Z]/.test(password);
        const hasLowerCase = /[a-z]/.test(password);
        const hasNumber = /[0-9]/.test(password);
        const hasSpecialChar = /[@$!%*?&]/.test(password);
        const isLongEnough = password.length >= 8;

        let strength = 0;
        if (hasUpperCase) strength++;
        if (hasLowerCase) strength++;
        if (hasNumber) strength++;
        if (hasSpecialChar) strength++;
        if (isLongEnough) strength++;

        return {
            score: strength,
            hasUpperCase,
            hasLowerCase,
            hasNumber,
            hasSpecialChar,
            isLongEnough,
            isStrong: strength >= 5 && isLongEnough
        };
    }

    // ================= PASSWORD FIELDS =================
    const passwordInput = document.getElementById("password");
    const confirmPasswordInput = document.getElementById("confirmPassword");
    const passwordError = document.getElementById("passwordError");
    const confirmPasswordError = document.getElementById("confirmPasswordError");

    // ================= LIVE PASSWORD VALIDATION =================
    if (passwordInput) {
        passwordInput.addEventListener("input", () => {
            const password = passwordInput.value;
            
            if (!password) {
                if (passwordError) passwordError.textContent = "";
                return;
            }

            const strength = getPasswordStrength(password);
            
            // Create strength indicator
            let strengthMessage = '';
            let strengthColor = '';
            
            if (!strength.isLongEnough) {
                strengthMessage = '❌ Password must be at least 8 characters';
                strengthColor = '#dc3545';
            } else if (strength.score < 3) {
                strengthMessage = '⚠️ Weak password - add more variety';
                strengthColor = '#dc3545';
            } else if (strength.score === 3) {
                strengthMessage = '⚠️ Medium password - add more characters and symbols';
                strengthColor = '#ffc107';
            } else if (strength.score >= 4 && strength.isLongEnough) {
                strengthMessage = '✅ Strong password!';
                strengthColor = '#28a745';
                passwordInput.classList.remove('input-error');
                passwordInput.classList.add('input-success');
            }

            // Show requirements if password is weak
            if (passwordError) {
                if (strength.score < 4 || !strength.isLongEnough) {
                    let requirements = [];
                    if (!strength.isLongEnough) requirements.push('8+ characters');
                    if (!strength.hasUpperCase) requirements.push('uppercase');
                    if (!strength.hasLowerCase) requirements.push('lowercase');
                    if (!strength.hasNumber) requirements.push('number');
                    if (!strength.hasSpecialChar) requirements.push('special character');
                    
                    passwordError.textContent = `Password needs: ${requirements.join(', ')}`;
                    passwordError.style.color = '#dc3545';
                } else {
                    passwordError.textContent = '✅ Strong password!';
                    passwordError.style.color = '#28a745';
                }
            }

            // Check confirm password if it has value
            if (confirmPasswordInput && confirmPasswordInput.value) {
                validateConfirmPassword();
            }
        });
    }

    // ================= CONFIRM PASSWORD VALIDATION =================
    function validateConfirmPassword() {
        if (!passwordInput || !confirmPasswordInput) return false;

        const password = passwordInput.value;
        const confirmPassword = confirmPasswordInput.value;

        if (!confirmPassword) {
            if (confirmPasswordError) confirmPasswordError.textContent = "";
            return false;
        }

        if (password !== confirmPassword) {
            if (confirmPasswordError) {
                confirmPasswordError.textContent = "❌ Passwords do not match";
                confirmPasswordError.style.color = '#dc3545';
            }
            confirmPasswordInput.classList.add("input-error");
            return false;
        } else {
            if (confirmPasswordError) {
                confirmPasswordError.textContent = "✅ Passwords match";
                confirmPasswordError.style.color = '#28a745';
            }
            confirmPasswordInput.classList.remove("input-error");
            confirmPasswordInput.classList.add("input-success");
            return true;
        }
    }

    if (confirmPasswordInput) {
        confirmPasswordInput.addEventListener("input", validateConfirmPassword);
    }

    // ================= LOGIN FORM =================
    const loginForm = document.getElementById("loginForm");

    if (loginForm) {
        loginForm.addEventListener("submit", (e) => {
            let valid = true;

            const email = document.getElementById("loginEmail");
            const regNo = document.getElementById("loginRegNo");

            clearError(email, "loginEmailError");
            clearError(regNo, "loginRegNoError");

            if (!emailPattern.test(email.value.trim())) {
                showError(email, "Invalid email format", "loginEmailError");
                valid = false;
            }

            if (!regPattern.test(regNo.value.trim())) {
                showError(regNo, "Format: S17/10777/22", "loginRegNoError");
                valid = false;
            }

            if (!valid) e.preventDefault();
        });
    }

    // ================= REGISTER FORM =================
    const registerForm = document.getElementById("registerForm");

    if (registerForm) {
        registerForm.addEventListener("submit", (e) => {
            let valid = true;

            const name = document.getElementById("name");
            const regNo = document.getElementById("regNo");
            const email = document.getElementById("email");
            const phone = document.getElementById("phone");

            // Clear all previous errors
            clearError(name, "nameError");
            clearError(regNo, "regNoError");
            clearError(email, "emailError");
            clearError(phone, "phoneError");
            if (passwordError) passwordError.textContent = "";
            if (confirmPasswordError) confirmPasswordError.textContent = "";

            // Name Validation
            if (!namePattern.test(name.value.trim())) {
                showError(name, "Letters and spaces only", "nameError");
                valid = false;
            }

            // Email Validation
            if (!emailPattern.test(email.value.trim())) {
                showError(email, "Invalid email format", "emailError");
                valid = false;
            }

            // Registration Number Validation
            if (!regPattern.test(regNo.value.trim())) {
                showError(regNo, "Format: S17/10777/22", "regNoError");
                valid = false;
            }

            // Phone Number Validation
            if (!phonePattern.test(phone.value.trim())) {
                showError(phone, "Phone number must start with 07 or 01 and contain 10 digits", "phoneError");
                valid = false;
            }

            // ================= IMPROVED PASSWORD VALIDATION =================
            if (passwordInput) {
                const password = passwordInput.value;
                const strength = getPasswordStrength(password);

                // Check if password is strong
                if (!password || !strength.isStrong) {
                    if (passwordError) {
                        if (!password) {
                            passwordError.textContent = "Password is required";
                        } else {
                            let requirements = [];
                            if (!strength.isLongEnough) requirements.push('8+ characters');
                            if (!strength.hasUpperCase) requirements.push('uppercase letter');
                            if (!strength.hasLowerCase) requirements.push('lowercase letter');
                            if (!strength.hasNumber) requirements.push('number');
                            if (!strength.hasSpecialChar) requirements.push('special character');
                            passwordError.textContent = `Password must include: ${requirements.join(', ')}`;
                        }
                        passwordError.style.color = '#dc3545';
                    }
                    passwordInput.classList.add("input-error");
                    valid = false;
                } else {
                    passwordInput.classList.remove("input-error");
                    passwordInput.classList.add("input-success");
                }
            }

            // ================= CONFIRM PASSWORD VALIDATION =================
            if (passwordInput && confirmPasswordInput) {
                const password = passwordInput.value;
                const confirmPassword = confirmPasswordInput.value;

                if (!confirmPassword) {
                    if (confirmPasswordError) {
                        confirmPasswordError.textContent = "Please confirm your password";
                        confirmPasswordError.style.color = '#dc3545';
                    }
                    confirmPasswordInput.classList.add("input-error");
                    valid = false;
                } else if (password !== confirmPassword) {
                    if (confirmPasswordError) {
                        confirmPasswordError.textContent = "Passwords do not match";
                        confirmPasswordError.style.color = '#dc3545';
                    }
                    confirmPasswordInput.classList.add("input-error");
                    valid = false;
                } else {
                    confirmPasswordInput.classList.remove("input-error");
                    confirmPasswordInput.classList.add("input-success");
                }
            }

            // If validation fails, prevent form submission
            if (!valid) {
                e.preventDefault();
                // Scroll to first error
                const firstError = document.querySelector('.input-error');
                if (firstError) {
                    firstError.focus();
                }
            }
        });
    }
    
//=======VALIDATING THE PAYMENT PAGE PHONE NUMBER========

    function validatePhone(phone) {
  const cleaned = phone.replace(/\D/g, '');
  const regex = /^254[17][0-9]{8}$/;
  const errorSpan = document.getElementById('phoneError');
  
  if (cleaned.length === 0) {
    errorSpan.textContent = '';
    return false;
  } else if (!regex.test(cleaned)) {
    errorSpan.textContent = 'Phone must start with 254, followed by 7 or 1, and 8 more digits';
    errorSpan.style.color = 'red';
    return false;
  } else {
    errorSpan.textContent = '✓ Valid phone number';
    errorSpan.style.color = 'green';
    return true;
  }
}

    // ================= REAL-TIME FIELD VALIDATION (Optional but recommended) =================
    // Add blur event listeners for better user experience
    
    // Name field real-time validation
    const nameField = document.getElementById("name");
    if (nameField) {
        nameField.addEventListener("blur", function() {
            const nameError = document.getElementById("nameError");
            if (this.value.trim() && !namePattern.test(this.value.trim())) {
                showError(this, "Letters and spaces only", "nameError");
            } else if (this.value.trim()) {
                clearError(this, "nameError");
            }
        });
    }

    // Email field real-time validation
    const emailField = document.getElementById("email");
    if (emailField) {
        emailField.addEventListener("blur", function() {
            const emailError = document.getElementById("emailError");
            if (this.value.trim() && !emailPattern.test(this.value.trim())) {
                showError(this, "Invalid email format", "emailError");
            } else if (this.value.trim()) {
                clearError(this, "emailError");
            }
        });
    }

    // Phone field real-time validation
    const phoneField = document.getElementById("phone");
    if (phoneField) {
        phoneField.addEventListener("blur", function() {
            const phoneError = document.getElementById("phoneError");
            if (this.value.trim() && !phonePattern.test(this.value.trim())) {
                showError(this, "Phone number must start with 07 or 01 and contain 10 digits", "phoneError");
            } else if (this.value.trim()) {
                clearError(this, "phoneError");
            }
        });
    }
});