import com.sap.gateway.ip.core.customdev.util.Message
import groovy.xml.*

def Message processData(Message message) {
    // Input
    def body = message.getBody(java.lang.String) as String

    // Slurper
    def input = new XmlSlurper().parseText(body)

    // Salida.
    def writer = new StringWriter()
    def xml = new MarkupBuilder(writer)

    xml.agenda {
        input.Contactos.Contacto.each { contacto ->
            def info = contacto.InformacionPersonal
            def contactoInfo = contacto.InformacionContacto

            person(id: info.id.text(),
                   alias: info.alias.text(),
                   email: info.CorreoElectronico.text(),
                   birthdate: info.FechaNacimiento.text()) {
                
                full_name("${info.Nombre.text()} ${info.Apellidos.text()}")
                
                phone_list {
                    contactoInfo.Telefonos.Telefono.each { tel ->
                        item(type: tel.@tipo.toString(), number: tel.text())
                    }
                }
                
                address_list {
                    contactoInfo.Direcciones.Direccion.each { dir ->
                        item(type: dir.@tipo.toString(), dir.text().trim())
                    }
                }
            }
        }
    }

    message.setBody(writer.toString())
    return message
}
