//
//  ViewController.swift
//  openlibrary
//
/*
 
 Semana 1
 
 Instrucciones
 
 En este entregable desarrollarás una aplicación usando Xcode que realice una petición a https://openlibrary.org/
 
 Para ello deberás crear una interfaz de usuario, usando la herramienta Storyboard que contenga:
 
 Una caja de texto para capturar el ISBN del libro a buscar
 EL botón de "enter" del teclado del dispositivo deberá ser del tipo de búsqueda ("Search")
 El botón de limpiar ("clear") deberá estar siempre presente
 Una vista texto (Text View) para mostrar el resultado de la petición
 Un ejemplo de URL para acceder a un libro es:
 
 https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:978-84-376-0494-7
 o
 https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:9789871138012
 
 Su programa deberá sustituir el último código de la URL anterior (en este caso 978-84-376-0494-7) por lo que se ponga en la caja de texto
 
 Al momento de presionar buscar en el teclado, se deberá mostrar los datos crudos (sin procesar) producto de la consulta en la vista texto en concordancia con el ISBN que se ingreso en la caja de texto
 
 En caso de error (problemas con Internet), se deberá mostrar una alerta indicando esta situación
 
 Sube tu solución a GitHub e ingresa la URL en el campo correspondiente
 
 
Semana 2
 
 En este entregable desarrollarás una aplicación usando Xcode que después de haber realizado una petición a https://openlibrary.org/ (entregable anterior) analice os datos JSON obtenidos y los presente de manera adecuada
 
 Para ello deberás crear una interfaz de usuario, usando la herramienta Storyboard que contenga:
 
 1. Una caja de texto para capturar el ISBN del libro a buscar
 
 2. EL botón de "enter" del teclado del dispositivo deberá ser del tipo de búsqueda ("Search")
 
 3. El botón de limpiar ("clear") deberá estar siempre presente
 
 4. En la vista deberás poner elementos para mostrar:
 
 El título del libro
 Los autores (recuerda que está en plural, pueden ser varios)
 La portada del libro (en caso de que exista)
 Un ejemplo de URL para acceder a un libro es:
 
 https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:978-84-376-0494-7
 
 Su programa deberá sustituir el último código de la URL anterior (en este caso 978-84-376-0494-7) por lo que se ponga en la caja de texto
 
 Al momento de presionar buscar en el teclado, la vista deberá mostrar los datos anteriormente descritos en concordancia con el ISBN que se ingreso en la caja de texto
 
 En caso de error (problemas con Internet), se deberá mostrar una alerta indicando esta situación
 
 Sube tu solución a GitHub e ingresa la URL en el campo correspondiente
 
 

 La aplicación deberá tener la funcionalidad especificada y en la vista se deberán encontrar los siguientes elementos:
 
 1. Una caja de texto para capturar el ISBN del libro a buscar
 
 2. EL botón de "enter" del teclado del dispositivo deberá ser del tipo de búsqueda ("Search")
 
 3. El botón de limpiar ("clear") deberá estar siempre presente
 
 4. En la vista deberás poner elementos para mostrar:
 
 El título del libro
 Los autores (recuerda que está en plural, pueden ser varios)
 La portada del libro (en caso de que exista)
 5. En caso de error (problemas con Internet), se deberá mostrar una alerta indicando esta situación
 
 */

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var SearchText: UITextField!
    
    
    @IBOutlet weak var TituloText: UITextField!
    @IBOutlet weak var AutoresText: UITextField!
    @IBOutlet weak var PortadaImage: UIImageView!
    @IBOutlet weak var OcultaPortadaLabel: UILabel!
    
    @IBOutlet weak var ResultViewText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ResultViewText.hidden = true
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ClearAcction(sender: AnyObject) {
        
        //self.SearchText.text = ""
        self.TituloText.text = ""
        self.AutoresText.text = ""
        self.OcultaPortadaLabel.hidden = false
        
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
        
            self.OcultaPortadaLabel.hidden = false
            
            let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
            
            let url = NSURL(string:urls + self.SearchText.text!)
            
            let datos:NSData? = NSData(contentsOfURL: url!)
            
            if (datos != nil) {
            
                let resultado = NSString(data: datos!, encoding: NSUTF8StringEncoding)
                
                if (resultado != "{}") {
                
                    self.ResultViewText.text = resultado! as String
                    
                    do {
                        
                        let jsonCrudo = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                     
                        let jsonDic = jsonCrudo as! NSDictionary
                        
                        let isbnDic = jsonDic["ISBN:\(self.SearchText.text!)"] as! NSDictionary
                        
                        ////////////////////////////////////////////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////////////////////////
                        if (isbnDic["title"] != nil) {
                            
                            let title = isbnDic["title"] as! NSString as String
                            
                            TituloText.text = title
                        
                        }
                        ////////////////////////////////////////////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////////////////////////
                        
                        ////////////////////////////////////////////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////////////////////////
                        if (isbnDic["authors"] != nil) {
                        
                            let authorsArray = isbnDic["authors"] as! NSArray
                            
                            var authors = "None"
                            
                            for i in 0...authorsArray.count-1 {
                                
                                if (i == 0) {
                                    
                                    authors = ("\(authorsArray[i]["name"]! as! NSString as String)")
                                    
                                }
                                else {
                                    
                                    authors += (", \(authorsArray[i]["name"]! as! NSString as String)")
                                    
                                }
                                
                            }
                        
                            AutoresText.text = authors as String
                        
                        }
                        ////////////////////////////////////////////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////////////////////////
                        
                        ////////////////////////////////////////////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////////////////////////
                        // De manera Asincrona
                        if (isbnDic["cover"] != nil) {
                            
                            let coverDic = isbnDic["cover"] as! NSDictionary
                            
                            if (coverDic["large"] != nil) {
                            
                                self.OcultaPortadaLabel.hidden = true
                                
                                let urlcoverL = coverDic["large"] as! NSString as String
                            
                                let url = NSURL(string: urlcoverL)
                                
                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                                    
                                    //make sure your image in this url does exist, otherwise unwrap in a if let check
                                    let data = NSData(contentsOfURL: url!)
                                    dispatch_async(dispatch_get_main_queue(), {
                                        self.PortadaImage.image = UIImage(data: data!)
                                    });
                                    
                                }
                            
                            }
                            
                        }
                        ////////////////////////////////////////////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////////////////////////////
                        
                    }
                    catch _ {
                        
                        let titulo = "Not Found"
                        let mensaje = "Error JSON"
                        let boton = "Ok"
                        
                        let alertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: boton, style: UIAlertActionStyle.Default,handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                        ClearAcction(Int(1))
                        
                    }
                
                }
                else {
                    
                    ClearAcction(Int(1))
                
                    let titulo = "Not Found"
                    let mensaje = "ISBN not found in https://openlibrary.org/"
                    let boton = "Ok"
                    
                    let alertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: boton, style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                }
                
            }
            else {
                
                ClearAcction(Int(1))
                
                let titulo = "Connection Error"
                let mensaje = "Connection Error"
                let boton = "Ok"
                
                let alertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: boton, style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            
            }
            
        }
        else {
            
            ClearAcction(Int(1))
            
            let titulo = "Not Found"
            let mensaje = "You need an ISBN"
            let boton = "Ok"
            
            let alertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: boton, style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }// End if
        
    }

}

