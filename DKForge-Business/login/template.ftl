<#import "field.ftl" as field>

<#macro postLoginForm>
    <div id="kc-form-login" class="${properties.kcFormClass}">
        <div id="kc-form-buttons" class="${properties.kcFormButtonsClass}">
            <#nested>
        </div>
    </div>
</#macro>

<#macro showUsernameIfAvailable>
    <#if auth?has_content && auth.showUsername()>
        <div class="kc-form-group">
            <label for="username">${msg("loginAs")}</label>
            <input
                id="username"
                type="text"
                class="kc-input-business"
                value="${auth.attemptedUsername}"
                readonly
                aria-label="${msg("loginAs")}"
            />
            <a href="${url.loginRestartFlowUrl}"
               class="kc-button-business kc-button-fullwidth">
                <span>${msg("restartLogin")}</span>
            </a>
        </div>
    </#if>
</#macro>

<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=true>
<!DOCTYPE html>

<#-- SAFE locale fallback (kcLocale can be missing in some contexts like error.ftl) -->
<#assign _kcLocale = kcLocale!{"language":"en","rtl":false,"languageTag":"en"}>

<#assign htmlLang = (_kcLocale.languageTag)!'en'>
<#assign textDir  = (_kcLocale.rtl!false)?then('rtl','ltr')>

<html class="${properties.kcHtmlClass!}" lang="${htmlLang}" dir="${textDir}">
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="DKForge Business Enterprise - Secure Access Platform">
    <title>${pageTitle!'DKForge Business'}</title>

    <link rel="stylesheet" href="${url.resourcesPath}/css/business.css">
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link rel="stylesheet" href="${url.resourcesPath}/${style}">
        </#list>
    </#if>
</head>

<body class="${bodyClass}">
<div class="kc-business-container">

    <!-- Sidebar -->
    <div class="kc-business-sidebar">
        <div class="kc-sidebar-content">
            <h1>${msg("businessSidebarTitle")?no_esc}</h1>
            <p>${msg("businessSidebarDescription")}</p>
            <ul class="kc-features-list">
                <li>${msg("businessFeature1")}</li>
                <li>${msg("businessFeature2")}</li>
                <li>${msg("businessFeature3")}</li>
                <li>${msg("businessFeature4")}</li>
            </ul>
        </div>
    </div>

    <!-- Main -->
    <div class="kc-business-main">

        <!-- Header -->
        <div class="kc-business-header">
            <div class="kc-logo-business">
                <span class="kc-logo-icon">${msg("businessLogoIcon")}</span>
                <div>
                    <div class="kc-logo-title">${msg("businessLogoText")}</div>
                    <div class="kc-logo-subtitle">${msg("businessEnterprise")}</div>
                </div>
            </div>

            <!-- ROW: header title (left) + locale (right) -->
            <div class="kc-business-header-row">

                <div class="kc-business-header-section">
                    <#nested "header">
                </div>

                <#-- Locale selector (EN/EL) - only if i18n enabled and >1 locale -->
                <#if realm.internationalizationEnabled?? && realm.internationalizationEnabled
                    && locale?? && locale.supported?? && (locale.supported?size gt 1)>

                    <div class="kc-locale-business" aria-label="${msg("language")}">
                        <label class="kc-locale-label-business" for="kc-locale-select">
                            ${msg("language")}
                        </label>

                        <select id="kc-locale-select"
                                class="kc-locale-select-business"
                                onchange="if (this.value) window.location.href=this.value;">
                            <#list locale.supported as l>
                                <#assign raw = (l.languageTag!l.label)!''>
                                <#assign code = raw?keep_before("_")?keep_before("-")?upper_case>

                                <#assign currentTag = (locale.currentLanguageTag!locale.current)!''>
                                <#assign thisTag = (l.languageTag!l.label)!''>

                                <option value="${l.url}" <#if thisTag == currentTag>selected</#if>>
                                    ${code}
                                </option>
                            </#list>
                        </select>
                    </div>

                </#if>

            </div>
        </div>

        <!-- Content -->
        <main class="kc-business-content">

            <#if displayMessage && message?has_content && message.type != 'error'>
                <div class="kc-alert kc-alert-${message.type}">
                    <span>${kcSanitize(message.summary)?no_esc}</span>
                </div>
            </#if>

            <div class="kc-form-container">
                <@showUsernameIfAvailable />
                <#nested "form">
                <#nested "socialProviders">
            </div>

            <#if displayInfo>
                <div class="kc-info-business">
                    <#nested "info">
                </div>
            </#if>
        </main>

        <!-- Footer -->
        <footer class="kc-business-footer">
            <p>${msg("businessFooterCopyright")}</p>
        </footer>

    </div>
</div>

<script type="module" src="${url.resourcesPath}/js/passwordVisibility.js"></script>
</body>
</html>
</#macro>