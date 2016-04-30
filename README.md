#PeticionServidorOpenlibrary

Instrucciones

En este entregable desarrollarás una aplicación usando Xcode que realice una petición a https://openlibrary.org/

Para ello deberás crear una interfaz de usuario, usando la herramienta Storyboard que contenga:

Una caja de texto para capturar el ISBN del libro a buscar
EL botón de "enter" del teclado del dispositivo deberá ser del tipo de búsqueda ("Search")
El botón de limpiar ("clear") deberá estar siempre presente
Una vista texto (Text View) para mostrar el resultado de la petición
Un ejemplo de URL para acceder a un libro es:

https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:978-84-376-0494-7

Su programa deberá sustituir el último código de la URL anterior (en este caso 978-84-376-0494-7) por lo que se ponga en la caja de texto

Al momento de presionar buscar en el teclado, se deberá mostrar los datos crudos (sin procesar) producto de la consulta en la vista texto en concordancia con el ISBN que se ingreso en la caja de texto

En caso de error (problemas con Internet), se deberá mostrar una alerta indicando esta situación

Sube tu solución a GitHub e ingresa la URL en el campo correspondiente
