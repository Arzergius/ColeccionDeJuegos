//
//  JuegosViewController.swift
//  ColeccionDeJuegos
//
//  Created by Aidan Silva on 17/05/23.
//

import UIKit

class JuegosViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var eliminarBoton: UIButton!
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    var imagePicker = UIImagePickerController()
    
    var juego:Juego? = nil
    @IBOutlet weak var JuegoimageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func agregarTapped(_ sender:Any){
        
        if juego != nil {
            juego!.titulo! = tituloTextField.text!
            juego!.imagen = JuegoimageView.image?.jpegData(compressionQuality: 0.50)
        }else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context: context)
            juego.titulo = tituloTextField.text
            juego.imagen = JuegoimageView.image?.jpegData(compressionQuality: 0.50)
            
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let juego = Juego(context: context)
//        juego.titulo = tituloTextField.text
//        juego.imagen = JuegoimageView.image?.jpegData(compressionQuality: 0.50)
//        (UIApplication.shared.delegate as! AppDelegate).saveContext()
//        navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada = info[.originalImage] as? UIImage
        JuegoimageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        if juego != nil {
            JuegoimageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        }else{
            eliminarBoton.isHidden = true
        }

    }
    

}
