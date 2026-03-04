/**
 * DKForge Theme Configuration
 * Customize colors, text, and branding elements
 */

const DKForgeConfig = {
  // Branding
  branding: {
    productName: "DKForge MVP",
    tagline: "Digital Products Studio",
    description: "Professional Digital Products Studio for cutting-edge development solutions.",
    fullDescription: "Unlock the power of enterprise-grade starter kits, customizable templates, and scalable architecture designed specifically for developers who demand excellence.",
  },

  // Colors
  colors: {
    primary: "#3b82f6",      // Blue
    primaryDark: "#2563eb",  // Darker Blue for hover
    background: "#0f0f0f",   // Almost Black
    surface: "#1a1a1a",      // Dark Gray for containers
    navbar: "#1e1e1e",       // Navbar background
    border: "#2a2a2a",       // Border color
    text: "#ffffff",         // White text
    textMuted: "#888",       // Muted gray text
    textSecondary: "#d0d0d0", // Secondary text
  },

  // Features List (shown in info panel)
  features: [
    "Production-ready starter kits with Quarkus, Keycloak & PostgreSQL",
    "Enterprise authentication & authorization templates",
    "Fully customizable digital product solutions",
    "Comprehensive documentation & developer support",
    "Scalable architecture for modern applications",
  ],

  // Links
  links: {
    appUrl: "http://localhost:5173/",
    appName: "Back to App",
  },

  // Localization
  i18n: {
    en: {
      featuresTitle: "What We Offer",
      description: "Professional Digital Products Studio for cutting-edge development solutions.",
    },
    el: {
      featuresTitle: "Τι Προσφέρουμε",
      description: "Επαγγελματικό Digital Products Studio για λύσεις ανάπτυξης επόμενης γενιάς.",
    },
  },
};

// Export for use in templates
if (typeof module !== 'undefined' && module.exports) {
  module.exports = DKForgeConfig;
}
