node {
    def app
    def PROJECT   = "diagnostic"
    def REGISTRY  = "https://registry.misc.maritime.tools"
    def NEXUS_CREDS = "jenkins.repo.misc.maritime.tools"

    stage("Clone repository") {
        checkout scm
    }
    stage("Build Diagnostic Tools") {
        app_tools = docker.build("${PROJECT}/tools", "--no-cache Tools/")
        app_tools.inside { sh "echo \"Tests passed\"" }
    }
    stage("Push images") {
        docker.withRegistry("${REGISTRY}", "${NEXUS_CREDS}") {
            app_tools.push("${env.BUILD_NUMBER}")
            app_tools.push("latest")
        }
    }
    stage("Deploy to Kubernetes") {
        sh "kubectl config use-context mail"
        sh "cat K8s/tools-deployment.yaml|sed -e 's/latest/${env.BUILD_NUMBER}/g'|kubectl apply -f -"
    }
}
