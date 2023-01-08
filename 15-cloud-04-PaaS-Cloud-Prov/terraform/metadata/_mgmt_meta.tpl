#cloud-config
users:
  - name: ${username_def}
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh-authorized-keys:
      - ${ssh_key_def}
      # - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9rackDcwZvm/J+sqLX7/qdZnNmbHenKyMdgPTfdADmzjoGDsWi5pefPg6MC1Ny+cLtp8MFVPrgxinusJNieEW+TWh0KY93c6FgUPkyAJ2uVcUI9B8nMZIjyMM1En7SJAtWZm4x1s8W4lz9+4cQpZ3Yn/nyZP/tR8T3AGD9B94O/t2zKMH0O8XiYqNgrdHkPTvarkLJLLV81Lv4XGLj6BDEjARpfwUPGkOcdzWOVYQCNmAN5dDlIqY4senukzjtKQKD/fUB2ZmqODG/5gnS6IUJNw6v1X0IgFD+fIHefbzgHiI4jgJQQaO2m7L7qsRdbEyFCpDfCiVZ89XAbX67BpvQZRseCVmkcmLAABhPjrFpdxVQfQFsSZMmT6W3hg6ygeHZd9+Hz+OVjtwDxct2yIDR71zRqIALX70YyVEYv8T24ehGyOfhE5xHZkhNwPpeBPI0oRmrdI/lAnBJUvM84KhiB5KFcoYIF2u9xmTGWr68vxBjHuc3AcnQVd0t3FBzKs= root@vagrant
      # - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDTbRkpp7ej0W4gnvG9Xwge2VdJxUuB+wlr36et/5lSVNUnXG/S/M1N9MEOk83F3zY/jgu4fEfCvhF18sBhu7tXcr0MoLVCfGS8vqLEw36tSQ7JJKXc7f7aWwHxh9bJSd1sO0c0amTUkViaO1MGXprZ72bY+KCIu2S7Qqcjw/qldriZj2WeuBShryMlZuYIuYvCBde3A+nOEhvq7vKr5yVDjeUBr4iGS1dn2OKLDfLqHHLfIo0A78xMDzbib4r3LscGPB+1m0sihQ7DA432Z6oxqMqSxBjblyZOP5ZTrfiI0aoU1cGVfB6cni+3i2tqsrzkyB6kZUvLcmDkFdMWkyW+CFpBU9If80rnhu5lLRX3cKmrQPuSx2lwDOSN59V+UwzHcMtZFS+2jagmSTMX1qkqXXwdtcYDzmtgOy77s8AzZmXDECL/a0uVvohJm8k1glGz2lewbfvqpcInZyu/S3/Nz2ukOg9Uipq/J2B4uaWUFvidEQ+i9vTMzArAHKnZlcJoCYHvbm8n+Glt4F7a/NoT6WY73j+dEJ4bhLZgPrYZYwNYjOwpAD/1sAOK5mnI1FT6wJRR9MsbEQ/mT0ku/VoY5Eq6hgbaq0SGLohKwPQA+CvF917ikm4p/juMfxjsOyksy62ExpsX1wdCajSYFtlGyT4O4yJBcn7CDU2kuG/Ztw== vagrant@vagrant
      # - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC06Rp5fbnyYg2ZPf3+ED6RX9+SV6OKl8ERgBQxuFdLfLHuHwZGdasMAm3KYZsvwK19NVbRzjm9Ga//7aaCJVJT2Wt/xWmkr1EqJHsMXG4moyOejg0qCFTVeXNwuYmIH3X62ArSbU0GViyv+iosg5yPhNKUU9fiRBsKpz9YOe1v4V84wb2Zms83rjyDDGq3NNUquJQkwh3ZLY9l/bEEN9g5wfcRpa0OXTX6lARpJah+z2h9Ys3Bb5elJdfgjk5YoAP46AualgM8RZ+JqWwicMkJ1Emy8737KXpIH8ooVfaUcf3BDzMjEpWAx1ak0GjJP4eWddjkguB76nzUNbYzagmorKar7LLRr3jyCMYcsiw1VMo9snQojpXJc5sOEyhGwsZulBCyqcoacdQXdoocxIXWioOPsB2SozGplkPBbRUmSHvhNY/fBonmZuCJi7vBMvlS6lb+ysCV9FLh6GZDjH4B0GFwUnmZ9CXM84LvUVrMKeYDRRqSgKolPS9aWI7oQlM= vagrant@vagrant
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8Ct8n5mlDiG+J8+sMYI1i5uwDHCP6+zW2TC2II3oJJF2MOxjpDgRIJ1nVqmTVIjmpmRrCai3FXBCte/PlSqOm7ZfvRAlLMdw5Uj2b/MKBw0T3QVN3eKFP6wBho+QvkAQfDBahDoMLCQvbV38vbDX5hgRfvrtxwDWb219BWVg3sBJhJKe397ykD7xRSHWc11z1H5mT+jW/E0eXM02oqLGyPJlH+Jz/XylgsM0rzYo+h+F1qHgj1qC3RcdqsgNyTmwMZ2mMQbinqxB/hMvufPG32/a3SMQqKbZjKhne7YGQdBAkc8XOa7DZis7ldAvoLRKo/YHWBzo92is0NSZBYyz1BXT2o1qSuOjuN1zMifdVL5Ugn0vYDB12NppvoamBUo3cjyZV9j5rrp6CSyaE5/T9fuvgUZLGXeyQd2ub3LjLVQ/rgKmxD08Y68wwodvnt1fgt3WzPt/4afg2F/J81eVlGktPSHvi6rqvHigVpGgD87V/290MzD0iH7iabGJcS3c= admugra\dmitrukuf@dmitrukuf

yum_repos:
  # The name of the repository
  Kubernetes:
    # Any repository configuration options
    # See: man yum.conf
    #
    # This one is required!
    baseurl: https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
    enabled: true
    failovermethod: priority
    gpgcheck: true
    gpgkey: https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
    name: Kubernetes

package_update: true
packages:
  - epel-release
  - git
  - mc
  - bash-completion
  - vim
  - kubectl
  - jq

write_files:
- encoding: b64
  content: |
    LS0tLS1CRUdJTiBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0KYjNCbGJuTnphQzFyWlhrdGRqRUFB
    QUFBQkc1dmJtVUFBQUFFYm05dVpRQUFBQUFBQUFBQkFBQUJsd0FBQUFkemMyZ3RjbgpOaEFBQUFB
    d0VBQVFBQUFZRUF6YkQrNVFDR0RKcTZheFI5SGNidDVYMVZNczRCdWlXbkVySUdERE51QllDMk9H
    UTJFWURyCkFIUkwyUlo0RXNGaGsvOGI5RkZGckQ4ZDA1OFh2dUlXSXcwWnVDdXNKQzMxRFJoNzZJ
    TFV6aE5TR3M0a1dBYWw4bWFwanQKSWlwak50WFJLdVhoL3NKcGdoQ1VyM1hTZXBwUitFSzlRQVhj
    dXRIcGxHWWhrc2VGR3U5d1ZDbTJmdllRRUNlNDdCSmJkbQo1WHJUSHRUbXNuOTFjMzdqYzhPT084
    WkovQ1UwU3NTRlZGbWp1Q3lXMC9ud09pejFGSk15eE9jbEI3TjFpUS9OaksvRGxSClRIOFRSNmE5
    eTlIYjdRV1BnRnNnWFBLL0RDN3ZYV3RlN2d1OHpNeGdVeVYycFYramt4TEJhTlkxOWc2RnBsVUtt
    TWJuYlQKK0FKZUQ5NWVqRVM3dmFCZzRwOEhPT3NLVW1ORDVxTTgvN2dSbUd3dXpyRmNyY1lsOWhG
    b3FuOUUvTUJlU1h4OWduQ2wvdgozQnR5dkhBWk5Yc1JBY0JJZDc1MTBjUy83QUdDak8yRUo0MFd5
    VlppMG9lWE8zWitwcm96YVRNOEx2ZXhjS0JYNkdVbHNKCis5QXRtMlVDR2tVRjVBSGp5NUFsQXFr
    bXBQSnBoVk9mSS91UXkrZ3BBQUFGaU1YdGxWakY3WlZZQUFBQUIzTnphQzF5YzIKRUFBQUdCQU0y
    dy91VUFoZ3lhdW1zVWZSM0c3ZVY5VlRMT0Fib2xweEt5Qmd3emJnV0F0amhrTmhHQTZ3QjBTOWtX
    ZUJMQgpZWlAvRy9SUlJhdy9IZE9mRjc3aUZpTU5HYmdyckNRdDlRMFllK2lDMU00VFVock9KRmdH
    cGZKbXFZN1NJcVl6YlYwU3JsCjRmN0NhWUlRbEs5MTBucWFVZmhDdlVBRjNMclI2WlJtSVpMSGhS
    cnZjRlFwdG43MkVCQW51T3dTVzNadVY2MHg3VTVySi8KZFhOKzQzUERqanZHU2Z3bE5FckVoVlJa
    bzdnc2x0UDU4RG9zOVJTVE1zVG5KUWV6ZFlrUHpZeXZ3NVVVeC9FMGVtdmN2UgoyKzBGajRCYklG
    enl2d3d1NzExclh1NEx2TXpNWUZNbGRxVmZvNU1Td1dqV05mWU9oYVpWQ3BqRzUyMC9nQ1hnL2VY
    b3hFCnU3MmdZT0tmQnpqckNsSmpRK2FqUFArNEVaaHNMczZ4WEszR0pmWVJhS3AvUlB6QVhrbDhm
    WUp3cGY3OXdiY3J4d0dUVjcKRVFIQVNIZStkZEhFdit3QmdvenRoQ2VORnNsV1l0S0hsenQyZnFh
    Nk0ya3pQQzczc1hDZ1YraGxKYkNmdlFMWnRsQWhwRgpCZVFCNDh1UUpRS3BKcVR5YVlWVG55UDdr
    TXZvS1FBQUFBTUJBQUVBQUFHQkFJeWdROFJBOVdUTXJFTGxRUjBJa2tEaHpVCnZzdUJXU0JJV3Ru
    S0RlMEl1R2tnNC94UTkyZWpSWFRqdmZOcnhyNWRDUEM0ZWZ3T2lnUmo0V2VOK1NKdHhUNm8rVm5C
    MG8KSm0rTG03czlKMHkwdk4rQ3JDcGFjVDRtbmluODFKK1liVjdDbE4vWkoxVERrV0tQRkV0bUFI
    L1o2ajBrdGhOcVdyT2V5eApYcWJCTGVsYVpndkVjUGFnT0I4emFTUk04S2NwalZ2bDFINVdtSDVy
    N05zNmZEdlF4MDVzUXlrMnZDcS8wZFErZDQ1SzJNCkpZZEFrVlk5eE9vRnRiVnNKaUZNNFZsN3NZ
    bWY2STRqbk9OcWJIQzRQWG0xRFZYUW1vMksyZlgzZEhsRFlsYzMrZXMxVW8KbGtIclRGTS9sYVNE
    a2tNN1A5YVg3SnorS3NpemRsL1YyejNFNGhac3lrb09FM2p4Mmt0LzJ3RWpJWVRTZ2JrQ2xjZGZJ
    SgpSeXlPU3RZa2JnSUpWYUtDNW1kR1dDNk16RUgvMVpWWEZpQnZwZ0FId2JzaVJKbzZmbGROMW1l
    bDNUOEh3MmV2cnBHWlJFCmpERW9VWXUxVHc4eHczTEQzTlVuNUs2YWZTWXY4VU1ZYW5RaEJyd2Fn
    S2xud2Y5cThCWXB0VEtwWktJTUZUeXYxeFlRQUEKQU1CMXBLS1RMU2lmZFc2VXpraXM3c1JUQTd6
    L1RpZkFhbTAvODRyV0kzS1NYZGoxeVZza2xpZG5oMGFGY1pWMG4wbTFIWgpBNjVlYVg5bldyVWxT
    ZHJhUlBjMlBiS0JqWnFSc3FOSHZDT0kvYWZYVzgrQk5SaURaekNJUkErNE54NGF3TWcrdjdnSE1r
    CjJXNVZDalUybHR5UWlZNFlPc1daSTA2UUtXRFZoWnFObVJGZ0RmSnVlN00rUHh1VTc2UzV0TXVl
    dzhSS0pyWTRlTFpzSS8KNkxnOU8vbGw1Q3pOMkYxVjhHV0g0OE8xREtyKzlPNm8xckN1TFVmekZ5
    RktoUExYZ0FBQURCQVAvUUtLZnYvMFBNcHBxUQpvWmZLRHRoRGU5cE5ETEpVenlMMldULy9NNVBl
    SUg0RWc0SlNiSUozTDVYbEV6MCtXVGk0dzZnSWN5Nkd1aWErUEpiajV0CmFFRnJmcitHUTJ2MXZv
    MFVTcHdreGJ5cXV2bkNaTlhILy8wQ2p4d05lVmNCWHhDMm9pVWNIeW1IcXN5MWdObHNpS1RuWXMK
    RFZvSkordmFuUjZRekYrYWQwM050ZWxUWnlJdXZWbFZrS1phSnlOcHdudGJrTlRxMTlnUXQ4aEho
    ZGxQMVNjL2xZZk56MwpEcjFoV0NsOUk0TWs2em1OeS8vOG1yVGZXS3N0Y1ZuUUFBQU1FQXpkZDJt
    b3B3RlUrS0FTS0RqMWhnTGM5Nk9uYVBpenVyCndaR0djREJ5ZHBnaEpuZjRwYUlXVTBXVmxpaFRs
    Z0k5b2N4Y01VejRDajFoN3crYmtuL1lFQlcvZHRYd0ZvS2JVYzR2cTMKQzNlQUd0WjFvZ1ZQZHA0
    bDZnbThvbC9sMzJkckJreEkvWjhPRlpVWGJBVWRRN0lRVXAxbnI4OVRhTWFldnFMSjVUbDdkaQpL
    Vk1QSDdMZWN1YU5JM3JseDV1aFZxL3hnM25WV2t0bVpkaklaWnppdVZyY0RvUVc0NVRGY1pYZ0ZO
    RmZ5N3hVZW9iSVJlCkpkK2t2anBSaWRPZno5QUFBQUQzWmhaM0poYm5SQWRtRm5jbUZ1ZEFFQ0F3
    PT0KLS0tLS1FTkQgT1BFTlNTSCBQUklWQVRFIEtFWS0tLS0tCg==
  owner: ${username_def}:${username_def}
  path: /tmp/cld-init/ssh/id_rsa
  permissions: '0600'
- encoding: b64
  content: |
    c3NoLXJzYSBBQUFBQjNOemFDMXljMkVBQUFBREFRQUJBQUFCZ1FETnNQN2xBSVlNbXJwckZIMGR4
    dTNsZlZVeXpnRzZKYWNTc2dZTU0yNEZnTFk0WkRZUmdPc0FkRXZaRm5nU3dXR1QveHYwVVVXc1B4
    M1RueGUrNGhZakRSbTRLNndrTGZVTkdIdm9ndFRPRTFJYXppUllCcVh5WnFtTzBpS21NMjFkRXE1
    ZUgrd21tQ0VKU3ZkZEo2bWxINFFyMUFCZHk2MGVtVVppR1N4NFVhNzNCVUtiWis5aEFRSjdqc0Vs
    dDJibGV0TWUxT2F5ZjNWemZ1Tnp3NDQ3eGtuOEpUUkt4SVZVV2FPNExKYlQrZkE2TFBVVWt6TEU1
    eVVIczNXSkQ4Mk1yOE9WRk1meE5IcHIzTDBkdnRCWStBV3lCYzhyOE1MdTlkYTE3dUM3ek16R0JU
    SlhhbFg2T1RFc0ZvMWpYMkRvV21WUXFZeHVkdFA0QWw0UDNsNk1STHU5b0dEaW53YzQ2d3BTWTBQ
    bW96ei91QkdZYkM3T3NWeXR4aVgyRVdpcWYwVDh3RjVKZkgyQ2NLWCsvY0czSzhjQmsxZXhFQndF
    aDN2blhSeEwvc0FZS003WVFualJiSlZtTFNoNWM3ZG42bXVqTnBNend1OTdGd29GZm9aU1d3bjcw
    QzJiWlFJYVJRWGtBZVBMa0NVQ3FTYWs4bW1GVTU4ais1REw2Q2s9IHZhZ3JhbnRAdmFncmFudAo=
  owner: ${username_def}:${username_def}
  path: /tmp/cld-init/ssh/id_rsa.pub
  permissions: '0644'


runcmd:
  - cloud-init single --name write_files --frequency once
  - chown -R ${username_def}:${username_def} /tmp/cld-init && chmod 0700 /tmp/cld-init && chmod 0600 /tmp/cld-init/ssh/id_rsa && chmod 0644 /tmp/cld-init/ssh/id_rsa.pub
  - mv /tmp/cld-init/ssh/id_rsa.pub /home/${username_def}/.ssh/ && mv /tmp/cld-init/ssh/id_rsa /home/${username_def}/.ssh/
  - kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
  - sudo -u ${username_def} sh -c 'curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash'
  - sudo -u ${username_def} /home/${username_def}/yandex-cloud/bin/yc config set cloud-id ${YC_cloud_id}
  - sudo -u ${username_def} /home/${username_def}/yandex-cloud/bin/yc config set folder-id ${YC_folder_id}
  - sudo -u ${username_def} /home/${username_def}/yandex-cloud/bin/yc managed-kubernetes cluster get-credentials ${k8s-id} --internal
