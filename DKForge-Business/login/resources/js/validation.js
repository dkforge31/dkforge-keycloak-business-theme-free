/**
 * DKForge Form Validation
 * Handles form validation with modal error messages
 */

class FormValidator {
  constructor() {
    this.errors = [];
    this.init();
  }

  init() {
    // Hook into form submissions
    document.querySelectorAll('form').forEach(form => {
      form.addEventListener('submit', (e) => this.handleSubmit(e, form));
    });

    // Close modal on Escape key
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape') {
        this.closeModal();
      }
    });

    // Delegate click handler for close buttons
    document.addEventListener('click', (e) => {
      if (e.target.classList.contains('validation-modal-close')) {
        this.closeModal();
      }
    });
  }

  handleSubmit(event, form) {
    this.errors = [];
    const formId = form.id || form.className;
    
    // Validate fields
    const isValid = this.validateFields(form);

    if (!isValid) {
      event.preventDefault();
      this.showModal();
      return false;
    }

    return true;
  }

  validateFields(form) {
    const fields = form.querySelectorAll('input[required], textarea[required], select[required]');
    let isValid = true;

    fields.forEach(field => {
      const value = field.value.trim();
      const fieldLabel = field.getAttribute('aria-label') || 
                        field.previousElementSibling?.textContent || 
                        field.name || 
                        'This field';

      // Clear previous error state
      field.parentElement.classList.remove('error');

      if (!value) {
        isValid = false;
        field.parentElement.classList.add('error');
        this.errors.push(`${fieldLabel} is required`);
      }

      // Validate email
      if (field.type === 'email' && value) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(value)) {
          isValid = false;
          field.parentElement.classList.add('error');
          this.errors.push(`${fieldLabel} must be a valid email address`);
        }
      }

      // Validate password strength (if password field)
      if (field.name === 'password' && value) {
        const passErrors = this.validatePassword(value);
        if (passErrors.length > 0) {
          isValid = false;
          field.parentElement.classList.add('error');
          passErrors.forEach(err => this.errors.push(err));
        }
      }

      // Validate password confirmation
      if (field.name === 'password-confirm' && value) {
        const passwordField = form.querySelector('input[name="password"]');
        if (passwordField && passwordField.value !== value) {
          isValid = false;
          field.parentElement.classList.add('error');
          this.errors.push('Passwords do not match');
        }
      }

      // Validate username length
      if (field.name === 'username' && value) {
        if (value.length < 3) {
          isValid = false;
          field.parentElement.classList.add('error');
          this.errors.push('Username must be at least 3 characters long');
        }
      }
    });

    return isValid;
  }

  validatePassword(password) {
    const errors = [];
    
    if (password.length < 8) {
      errors.push('Password must be at least 8 characters');
    }
    if (!/[A-Z]/.test(password)) {
      errors.push('Password must contain at least one uppercase letter');
    }
    if (!/[0-9]/.test(password)) {
      errors.push('Password must contain at least one number');
    }
    
    return errors;
  }

  showModal() {
    let modal = document.getElementById('validation-modal');
    if (!modal) {
      this.createModal();
      modal = document.getElementById('validation-modal');
    } else {
      this.updateModal();
    }
    // Ensure modal is visible
    modal.classList.add('active');
    modal.style.display = 'flex';
  }

  createModal() {
    const modal = document.createElement('div');
    modal.id = 'validation-modal';
    modal.className = 'validation-modal active';
    modal.style.display = 'flex';
    
    const errorsList = this.errors.map(error => `<li style="color: #ef4444; font-weight: 500;">${error}</li>`).join('');
    
    modal.innerHTML = `
      <div class="validation-modal-content">
        <div class="validation-modal-header" style="color: #ef4444;">⚠️ Validation Errors</div>
        <div class="validation-modal-message" style="color: #ef4444; font-weight: 500;">
          Please fix the following errors:
        </div>
        <ul class="validation-modal-errors" id="validation-errors" style="color: #ef4444;">
          ${errorsList}
        </ul>
        <button type="button" class="validation-modal-close" style="background: #ef4444; color: white; border: none; padding: 12px 24px; border-radius: 6px; cursor: pointer; font-weight: 600; width: 100%; transition: background-color 0.25s; font-size: 1em; margin-top: 10px;">× Close</button>
      </div>
    `;
    
    document.body.appendChild(modal);
    
    // Close button handler
    const closeBtn = modal.querySelector('.validation-modal-close');
    closeBtn.addEventListener('click', (e) => {
      e.preventDefault();
      e.stopPropagation();
      modal.remove();
      this.errors = [];
    });

    // Close on backdrop click
    modal.addEventListener('click', (e) => {
      if (e.target === modal) {
        modal.remove();
        this.errors = [];
      }
    });
  }

  updateModal() {
    const errorList = document.getElementById('validation-errors');
    if (errorList) {
      errorList.innerHTML = this.errors.map(error => `<li>${error}</li>`).join('');
    }
  }

  closeModal() {
    const modal = document.getElementById('validation-modal');
    if (modal) {
      modal.remove();
      this.errors = [];
    }
  }
}

// Register success handling
class RegisterSuccess {
  constructor() {
    this.init();
  }

  init() {
    const urlParams = new URLSearchParams(window.location.search);
    const isRegisterSuccess = urlParams.get('registerSuccess') === 'true';

    if (isRegisterSuccess) {
      this.showSuccess();
      this.setCookie();
    }
  }

  showSuccess() {
    const successMsg = document.querySelector('.register-success');
    if (successMsg) {
      successMsg.classList.add('active');
    } else {
      this.createSuccessMessage();
    }
  }

  createSuccessMessage() {
    const formContainer = document.querySelector('.kc-form-container');
    if (formContainer) {
      const successDiv = document.createElement('div');
      successDiv.className = 'register-success active';
      successDiv.textContent = 'Registration successful! You can now log in.';
      formContainer.insertBefore(successDiv, formContainer.firstChild);
    }
  }

  setCookie() {
    const now = new Date();
    const time = now.getTime();
    const expireTime = time + 24 * 60 * 60 * 1000; // 24 hours
    now.setTime(expireTime);

    document.cookie = `dkforge_register_success=true; expires=${now.toUTCString()}; path=/`;
    document.cookie = `dkforge_register_date=${new Date().toISOString()}; expires=${now.toUTCString()}; path=/`;
  }
}

// Initialize validators when DOM is ready
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', () => {
    new FormValidator();
    new RegisterSuccess();
  });
} else {
  new FormValidator();
  new RegisterSuccess();
}
