<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=false; section>

    <#if section = "header">
        ${kcSanitize(msg("errorTitle"))?no_esc}

    <#elseif section = "form">
        <div class="kc-error-page">
            <div class="error-icon">⚠️</div>

            <h2>${kcSanitize(message.summary)?no_esc}</h2>
            <p>${kcSanitize(msg("errorSummaryDefault"))?no_esc}</p>

            <#if !skipLink??>
                <#if client?? && client.baseUrl?has_content>
                    <a href="${client.baseUrl}"
                       class="kc-button-business kc-error-button-business"
                       id="backToApplication">
                        ${kcSanitize(msg("backToApplication"))?no_esc}
                    </a>
                </#if>
            </#if>
        </div>
    </#if>

</@layout.registrationLayout>