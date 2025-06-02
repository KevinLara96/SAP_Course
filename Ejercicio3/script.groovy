import com.sap.gateway.ip.core.customdev.util.Message

Message processData(Message message) {
    def logInfo = new StringBuilder()

    logInfo.append("=== Headers Properties ===\n")
    message.getHeaders().each { key, value ->
        logInfo.append("${key}: ${value}\n")
    }


    logInfo.append("\n=== Exchange and Custom Properties ===\n")
    message.getProperties().each { key, value ->
        logInfo.append("${key}: ${value}\n")
    }

    message.setBody(logInfo.toString())
    return message
}

