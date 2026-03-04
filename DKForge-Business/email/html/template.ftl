<#macro emailLayout>
<!DOCTYPE html>
<html lang="${locale.language}" dir="${(ltr!true)?then('ltr','rtl')}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${msg("emailTitle")}</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --business-dark: #1e3a5f;
            --business-light: #c7d2e0;
            --business-accent: #2c5aa0;
            --business-success: #27ae60;
            --business-shadow: 0 4px 12px rgba(30, 58, 95, 0.15);
        }

        body {
            font-family: 'Georgia', 'Garamond', serif;
            background: #f0f2f5;
            color: #333;
            line-height: 1.6;
        }

        .email-container {
            max-width: 600px;
            margin: 20px auto;
            background: #ffffff;
            border-left: 5px solid var(--business-dark);
            box-shadow: var(--business-shadow);
            overflow: hidden;
        }

        .email-header {
            background: linear-gradient(135deg, var(--business-dark) 0%, var(--business-accent) 100%);
            padding: 50px 40px;
            text-align: left;
            color: #ffffff;
            border-bottom: 3px solid var(--business-success);
        }

        .email-header h1 {
            font-size: 32px;
            margin-bottom: 8px;
            font-weight: 700;
            letter-spacing: 0.5px;
            line-height: 1.2;
        }

        .realm-name {
            font-size: 28px;
            margin-bottom: 15px;
            font-weight: 600;
            color: #ffffff;
        }

        .email-subtitle {
            font-size: 13px;
            color: rgba(255, 255, 255, 0.9);
            letter-spacing: 1px;
            text-transform: uppercase;
            font-weight: 500;
        }

        .email-body {
            padding: 45px 40px;
            background: #ffffff;
            color: #333;
        }

        .email-body p {
            margin-bottom: 18px;
            font-size: 15px;
            line-height: 1.8;
            color: #444;
        }

        .email-body a {
            color: var(--business-accent);
            text-decoration: none;
            font-weight: 600;
            border-bottom: 2px solid var(--business-accent);
            transition: all 0.3s ease;
        }

        .email-body a:hover {
            color: var(--business-dark);
            border-bottom-color: var(--business-dark);
        }

        .email-button {
            display: inline-block;
            background: linear-gradient(135deg, var(--business-dark) 0%, var(--business-accent) 100%);
            color: #ffffff;
            padding: 14px 40px;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 700;
            font-size: 14px;
            margin: 25px 0;
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 1px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: var(--business-shadow);
        }

        .email-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(30, 58, 95, 0.3);
        }

        .feature-box {
            display: inline-block;
            background: #f8f9fa;
            border-left: 4px solid var(--business-success);
            padding: 18px 20px;
            margin: 20px 0;
            border-radius: 4px;
            width: 100%;
        }

        .feature-box strong {
            color: var(--business-dark);
            display: block;
            margin-bottom: 8px;
        }

        .checkmark {
            color: var(--business-success);
            font-weight: bold;
            margin-right: 8px;
        }

        .trust-section {
            background: linear-gradient(135deg, rgba(30, 58, 95, 0.03) 0%, rgba(44, 90, 160, 0.03) 100%);
            border: 1px solid rgba(30, 58, 95, 0.1);
            border-radius: 6px;
            padding: 25px;
            margin: 25px 0;
        }

        .trust-section h3 {
            color: var(--business-dark);
            font-size: 16px;
            margin-bottom: 12px;
            font-weight: 700;
        }

        .code-block {
            background: #f5f5f5;
            border-left: 3px solid var(--business-accent);
            border-radius: 4px;
            padding: 15px;
            font-family: 'Courier New', monospace;
            font-size: 13px;
            color: var(--business-dark);
            overflow-x: auto;
            margin: 20px 0;
            word-break: break-all;
        }

        .email-footer {
            background: #f8f9fa;
            padding: 35px 40px;
            text-align: center;
            border-top: 2px solid #e0e0e0;
            font-size: 12px;
            color: #666;
        }

        .email-footer p {
            margin: 8px 0;
            font-size: 12px;
        }

        .footer-divider {
            height: 1px;
            background: #d0d0d0;
            margin: 15px 0;
        }

        .trust-badge {
            display: inline-block;
            background: var(--business-dark);
            color: #ffffff;
            padding: 8px 12px;
            border-radius: 3px;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin: 5px;
            font-weight: 600;
        }

        @media (max-width: 600px) {
            .email-container {
                border-left-width: 3px;
            }
            .email-header {
                padding: 30px 20px;
            }
            .email-header h1 {
                font-size: 24px;
            }
            .realm-name {
                font-size: 22px;
            }
            .email-body {
                padding: 25px 20px;
            }
            .email-footer {
                padding: 25px 20px;
            }
        }
    </style>
</head>
<body>
    <div class="email-container">
        <div class="email-header">
            <div class="realm-name">${realmName!}</div>
            <h1>${msg("businessPortal")}</h1>
            <div class="email-subtitle">${msg("emailSubtitle")}</div>
        </div>

        <div class="email-body">
            <#nested>
        </div>

        <div class="email-footer">
            <p><strong>${msg("emailFooterBrand")}</strong></p>
            <p>${msg("securityPromo")}</p>
            <div class="footer-divider"></div>
            <span class="trust-badge">${msg("emailTrustBadge1")}</span>
            <span class="trust-badge">${msg("emailTrustBadge2")}</span>
            <span class="trust-badge">${msg("emailTrustBadge3")}</span>
            <div class="footer-divider"></div>
            <p>${msg("emailCopyrightNotice")}</p>
        </div>
    </div>
</body>
</html>
</#macro>
