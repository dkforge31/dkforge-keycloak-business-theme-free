// DKForge Business - Professional Interactions
document.addEventListener('DOMContentLoaded', function() {
    // Input focus effect
    const inputs = document.querySelectorAll('.kc-input-business');
    inputs.forEach(input => {
        input.addEventListener('focus', function() {
            this.style.borderColor = '#2c5aa0';
            this.style.boxShadow = '0 0 8px rgba(44, 90, 160, 0.2)';
        });
        input.addEventListener('blur', function() {
            this.style.borderColor = '';
            this.style.boxShadow = '';
        });
    });

    // Form submission button effect
    const button = document.querySelector('.kc-button-business');
    if (button) {
        button.addEventListener('click', function() {
            this.style.opacity = '0.8';
        });
        button.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-2px)';
        });
        button.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });
    }

    // Checkbox styling
    const checkbox = document.getElementById('rememberMe');
    if (checkbox) {
        checkbox.addEventListener('change', function() {
            this.parentElement.style.transform = this.checked ? 'scale(1.02)' : 'scale(1)';
        });
    }
});
