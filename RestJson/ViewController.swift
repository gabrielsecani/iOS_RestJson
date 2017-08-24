//
//  ViewController.swift
//  RestJson
//
//  Created by Usuário Convidado on 24/08/17.
//  Copyright © 2017 Gabriel Ribeiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var minhaImagem: UIImageView!
    @IBOutlet weak var local: UILabel!
    @IBOutlet weak var estado: UILabel!
    
    var session: URLSession?
    
    @IBAction func exibir(_ sender: Any) {
        let config = URLSessionConfiguration.default
        
        session = URLSession(configuration: config)
        let url = URL(string: "https://parks-api.herokuapp.com/parks/57b702ae8560c511000ff348")
        
        let task = session?.dataTask(with: url!, completionHandler: { (data, response, error) in
            // ações que serão efetuadas qunado
            // a execução da task se completa
            let texto = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
             print(texto!)
            if let nPQ = self.retornaNomePq(data: data!){
                DispatchQueue.main.async {
                    self.local.text = nPQ
                }
            }
            if let ePQ = self.retornaEstadoParque(data: data!){
                DispatchQueue.main.async {
                    self.estado.text = ePQ
                }
            }
        })
        // a ln abaixo dispara a execução da task
        task?.resume()
    }
    
    func retornaNomePq(data: Data) -> String? {
        var resposta:String?=nil
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            if let nomeParque = json["nome"] as? String{
                resposta = nomeParque
            }
        }catch let error as NSError{
            return "Falha as carregar: \(error.localizedDescription)"
        }
        return resposta
    }
    
    func retornaEstadoParque(data: Data) -> String? {
        var resposta:String?=nil
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            if let nomeEstado = json["estado"] as? String{
                resposta = nomeEstado
            }
        }catch let error as NSError{
            return "Falha as carregar: \(error.localizedDescription)"
        }
        return resposta
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

