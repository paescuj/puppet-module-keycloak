# @summary Define Keycloak resources
# @api private
class keycloak::resources {
  assert_private()

  if $keycloak::realms_merge {
    $realms = lookup('keycloak::realms', Hash, 'deep', {})
  } else {
    $realms = $keycloak::realms
  }
  if $keycloak::oidc_client_scopes_merge {
    $oidc_client_scopes = lookup('keycloak::oidc_client_scopes', Hash, 'deep', {})
  } else {
    $oidc_client_scopes = $keycloak::oidc_client_scopes
  }
  if $keycloak::saml_client_scopes_merge {
    $saml_client_scopes = lookup('keycloak::saml_client_scopes', Hash, 'deep', {})
  } else {
    $saml_client_scopes = $keycloak::saml_client_scopes
  }
  if $keycloak::client_scopes_merge {
    $client_scopes = lookup('keycloak::client_scopes', Hash, 'deep', {})
  } else {
    $client_scopes = $keycloak::client_scopes
  }
  if $keycloak::protocol_mappers_merge {
    $protocol_mappers = lookup('keycloak::protocol_mappers', Hash, 'deep', {})
  } else {
    $protocol_mappers = $keycloak::protocol_mappers
  }
  if $keycloak::identity_providers_merge {
    $identity_providers = lookup('keycloak::identity_providers', Hash, 'deep', {})
  } else {
    $identity_providers = $keycloak::identity_providers
  }
  if $keycloak::clients_merge {
    $clients = lookup('keycloak::clients', Hash, 'deep', {})
  } else {
    $clients = $keycloak::clients
  }
  if $keycloak::flows_merge {
    $flows = lookup('keycloak::flows', Hash, 'deep', {})
  } else {
    $flows = $keycloak::flows
  }
  if $keycloak::flow_executions_merge {
    $flow_executions = lookup('keycloak::flow_executions', Hash, 'deep', {})
  } else {
    $flow_executions = $keycloak::flow_executions
  }

  $realms.each |$name, $realm| {
    keycloak_realm { $name: * => $realm }
  }
  $oidc_client_scopes.each |$name, $scope| {
    keycloak::client_scope::oidc { $name: * => $scope }
  }
  $saml_client_scopes.each |$name, $scope| {
    keycloak::client_scope::saml { $name: * => $scope }
  }
  $client_scopes.each |$name, $client_scope| {
    keycloak_client_scope { $name: * => $client_scope }
  }
  $protocol_mappers.each |$name, $protocol_mapper| {
    keycloak_protocol_mapper { $name: * => $protocol_mapper }
  }
  $identity_providers.each |$name, $data| {
    keycloak_identity_provider { $name: * => $data }
  }
  $clients.each |$name, $data| {
    keycloak_client { $name: * => $data }
  }
  $flows.each |$name, $data| {
    keycloak_flow { $name: * => $data }
  }
  $flow_executions.each |$name, $data| {
    keycloak_flow_execution { $name: * => $data }
  }
  $keycloak::spi_deployments.each |$name, $deployment| {
    keycloak::spi_deployment { $name: * => $deployment }
  }
}