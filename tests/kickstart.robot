*** Settings ***
Library    SSHLibrary

*** Test Cases ***
Check if semaphoreui is installed correctly
    ${output}  ${rc} =    Execute Command    add-module ${IMAGE_URL} 1
    ...    return_rc=True
    Should Be Equal As Integers    ${rc}  0
    &{output} =    Evaluate    ${output}
    Set Suite Variable    ${module_id}    ${output.module_id}

Check if semaphoreui can be configured
    ${rc} =    Execute Command    api-cli run module/${module_id}/configure-module --data '{}'
    ...    return_rc=True  return_stdout=False
    Should Be Equal As Integers    ${rc}  0

Check if semaphoreui works as expected
    ${rc} =    Execute Command    curl -f http://127.0.0.1/semaphoreui/
    ...    return_rc=True  return_stdout=False
    Should Be Equal As Integers    ${rc}  0

Check if semaphoreui is removed correctly
    ${rc} =    Execute Command    remove-module --no-preserve ${module_id}
    ...    return_rc=True  return_stdout=False
    Should Be Equal As Integers    ${rc}  0
