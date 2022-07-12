pipeline {
    agent {
      label 'linux'
    }

    stages {
      stage('prepare') {
        steps {
                sh '''pip3 install --user "molecule==3.4.0" "molecule_docker"
                    molecule --version'''
        }
      }
    
      stage('clone_repo') {
        steps {
          checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'd3bbb3f9-6b7a-4b85-81a9-53d78954bb7a', url: 'git@github.com:Nb3l77eo/ansible_role_vector.git']]])
        }
      }

      stage('link role') {
        steps {
          sh '''mkdir -p roles
            ln -sf `pwd` roles/`cat meta/main.yml | grep role_name: | awk '{print $2}'`'''
        }
      }

      stage('moleculre test -s centos_7') {
        steps {
          sh '''molecule test -s centos_7'''
        }
      }
    }
}
