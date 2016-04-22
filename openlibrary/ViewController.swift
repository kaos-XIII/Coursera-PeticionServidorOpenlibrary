//
//  ViewController.swift
//  openlibrary
//
/*
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
 */

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var SearchText: UITextField!
    @IBOutlet weak var ResultViewText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ClearAcction(sender: AnyObject) {
        
        self.SearchText.text = ""
        self.ResultViewText.text = ""
        
    }
    
    //
    //Esconde teclado si tocas pantalla.
    //
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        super.touchesBegan(touches, withEvent: event)
        view.endEditing(true);
        
    }
    
    //
    // Presionas "ENTER" se esconde el teclado. (Por metodo de Delegacion)
    // Mirar que en la clase ViewControler tiene UITextFieldDelegate
    // Cada caja de Texto tiene que tener el delegate del viewController
    //
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        buscar()
        
        textField.resignFirstResponder();
        return false;
        
    }
    
    func buscar(){
        
        if (self.SearchText.text != nil && self.SearchText.text != "") {
        
            let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
            
            let url = NSURL(string:urls + self.SearchText.text!)
            
            let datos:NSData? = NSData(contentsOfURL: url!)
            
            if (datos != nil) {
            
                let resultado = NSString(data: datos!, encoding: NSUTF8StringEncoding)
                
                if (resultado != "{}") {
                
                    self.ResultViewText.text = resultado! as String
                
                }
                else {
                
                    let titulo = "Not Found"
                    let mensaje = "ISBN not found in https://openlibrary.org/"
                    let boton = "Ok"
                    
                    let alertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: boton, style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                    self.SearchText.text = ""
                    self.ResultViewText.text = ""
                    
                }
                
            }
            else {
                
                let titulo = "Connection Error"
                let mensaje = "Connection Error"
                let boton = "Ok"
                
                let alertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: boton, style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
                self.SearchText.text = ""
                self.ResultViewText.text = ""
            
            }
            
        }
        else {
            
            let titulo = "Not Found"
            let mensaje = "You need an ISBN"
            let boton = "Ok"
            
            let alertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: boton, style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            self.SearchText.text = ""
            self.ResultViewText.text = ""
            
        }// End if
        
    }

}

