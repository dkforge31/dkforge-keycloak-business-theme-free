<#macro group name label error="" required=false>

<div class="kc-form-group">
    <label for="${name}" class="form-label">
        ${label}
        <#if required>
            <span aria-hidden="true">*</span>
        </#if>
    </label>

    <#nested>

    <#if error?has_content>
        <span class="kc-error-msg" aria-live="polite">
            ${kcSanitize(error)?no_esc}
        </span>
    </#if>
</div>

</#macro>

<#macro input name label value="" required=false autocomplete="off" fieldName=name autofocus=false>
  <#assign error="">
  <#if messagesPerField.existsError(fieldName)>
    <#assign error=messagesPerField.getFirstError(fieldName)>
  </#if>
  <@group name=name label=label error=error required=required>
    <input id="${name}" name="${name}" value="${value}" type="text" autocomplete="${autocomplete}" 
            <#if autofocus>autofocus</#if>
            class="kc-input-business"
            <#if autocomplete == "one-time-code">inputmode="numeric"</#if>
            aria-invalid="<#if error?has_content>true</#if>"/>
  </@group>
</#macro>

<#macro password name label value="" required=false forgotPassword=false fieldName=name autocomplete="off" autofocus=false>
  <#assign error="">
  <#if messagesPerField.existsError(fieldName)>
    <#assign error=messagesPerField.getFirstError(fieldName)>
  </#if>
  <@group name=name label=label error=error required=required>
    <div class="kc-password-wrapper">
        <input id="${name}" name="${name}" value="${value}" type="password" autocomplete="${autocomplete}" 
                <#if autofocus>autofocus</#if>
                class="kc-input-business"
                aria-invalid="<#if error?has_content>true</#if>"/>
        <button class="kc-toggle-password" type="button" aria-controls="${name}" data-password-toggle
                data-icon-show="bi-eye" data-icon-hide="bi-eye-slash">🔐<i class="bi bi-eye" style="display:none;"></i></button>
    </div>
    <#if forgotPassword>
        <div style="margin-top: 8px;">
            <a href="${url.loginResetCredentialsUrl}" class="helper-link">${msg("doForgotPassword")}</a>
        </div>
    </#if>
    <#nested>
  </@group>
</#macro>

<#macro select name label value="" required=false fieldName=name options=[]>
  <#assign error="">
  <#if messagesPerField.existsError(fieldName)>
    <#assign error=messagesPerField.getFirstError(fieldName)>
  </#if>
  <@group name=name label=label error=error required=required>
    <select id="${name}" name="${name}" class="kc-input-business" aria-invalid="<#if error?has_content>true</#if>">
        <option value="">${msg("chooseOption")}</option>
        <#list options as option>
            <option value="${option}" <#if value == option>selected</#if>>${option}</option>
        </#list>
    </select>
  </@group>
</#macro>

<#macro checkbox name label value=false required=false>
  <div style="margin-bottom: 16px;">
    <label for="${name}" style="display: flex; align-items: center; gap: 8px;">
      <input
        class=""
        type="checkbox"
        id="${name}"
        name="${name}"
        <#if value>checked</#if>
        <#if required>required</#if>
      />
      <span>${label}</span>
    </label>
  </div>
</#macro>
