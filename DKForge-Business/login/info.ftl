<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        <#if messageHeader??>
            ${kcSanitize(msg("${messageHeader}"))?no_esc}
        <#else>
            ${kcSanitize(message.summary)?no_esc}
        </#if>

    <#elseif section = "form">
        <div class="kc-info-page">

            <div class="info-icon">
                ${msg("businessIconInfo")!""}
            </div>

            <h2>
                <#if messageHeader??>
                    ${kcSanitize(msg("${messageHeader}"))?no_esc}
                <#else>
                    ${kcSanitize(message.summary)?no_esc}
                </#if>
            </h2>

            <p>
                ${kcSanitize(message.summary)?no_esc}
                <#if requiredActions??>
                    :
                    <b>
                        <#list requiredActions as ra>
                            ${kcSanitize(msg("requiredAction.${ra}"))?no_esc}<#sep>, 
                        </#list>
                    </b>
                </#if>
            </p>

            <#if !skipLink??>
                <#if pageRedirectUri?has_content>
                    <span class="kc-password-recovery">
                        <a href="${pageRedirectUri}">
                            ${kcSanitize(msg("backToApplication"))?no_esc}
                        </a>
                    </span>

                <#elseif actionUri?has_content>
                    <span class="kc-password-recovery">
                        <a href="${actionUri}">
                            ${kcSanitize(msg("proceedWithAction"))?no_esc}
                        </a>
                    </span>

                <#elseif (client.baseUrl)?has_content>
                    <span class="kc-password-recovery">
                        <a href="${client.baseUrl}">
                            ${kcSanitize(msg("backToApplication"))?no_esc}
                        </a>
                    </span>

                <#elseif url.loginUrl?has_content>
                    <span class="kc-password-recovery">
                        <a href="${url.loginUrl}">
                            ${kcSanitize(msg("backToLogin"))?no_esc}
                        </a>
                    </span>
                </#if>
            </#if>

        </div>
    </#if>
</@layout.registrationLayout>