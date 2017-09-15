//
//  ViewController.swift
//  RestJson
//
//  Created by Usuário Convidado on 14/09/17.
//  Copyright © 2017 Usuário Convidado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cep: UITextField!
    @IBOutlet weak var ender: UITextField!
    @IBOutlet weak var bairro: UITextField!
    @IBOutlet weak var cidade: UITextField!
    @IBOutlet weak var uf: UITextField!
    
    var session: URLSession?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func BuscarCEP(_ sender: Any) {
        
        let config = URLSessionConfiguration.default
        
        session = URLSession(configuration: config)
        let url = URL(string: "http://viacep.com.br/ws/\(cep.text!)/json/")
        print(url!)
        let task = session?.dataTask(with: url!, completionHandler: { (data, response, error) in
            // ações que serão efetuadas qunado
            // a execução da task se completa
            
            
            let ende = self.retornaCampo(data: data!, campo: "logradouro")
            let estado = self.retornaCampo(data: data!, campo: "localidade")
            let bairro = self.retornaCampo(data: data!, campo: "bairro")
            let city = self.retornaCampo(data: data!, campo: "uf")
            
            DispatchQueue.main.async {
                self.bairro.text = bairro
                self.ender.text = ende
                self.cidade.text = city
                self.uf.text = estado
            }
            
        })
        // a ln abaixo dispara a execução da task
        task?.resume()

    }
    
    func retornaCampo(data: Data, campo: String) -> String? {
        var resposta:String?=nil
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            if let valor = json[campo] as? String{
                resposta = valor
            }
        }catch let error as NSError{
            return "Falha as carregar: \(error.localizedDescription)"
        }
        return resposta
    }
    
    func retornaArray(data: Data) -> [String] {
        var respostaArray:[String] = []
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            
            if let logradouro = json["logradouro"] as? String{
                if let localidade = json["localidade"] as? String{
                    if let bairro = json["bairro"] as? String{
                        if let uf = json["uf"] as? String{
                            respostaArray = [logradouro, localidade, bairro, uf]
                        }
                    }
                }
            }
        }catch let error as NSError{
            print("Falha as carregar: \(error.description)")
        }
        return respostaArray
    }

    
}

