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
    
    @IBOutlet weak var cep: UITextField!
    @IBOutlet weak var ender: UITextField!
    var session: URLSession?
    
    
    @IBAction func buscarCEP(_ sender: Any) {
        
        let config = URLSessionConfiguration.default
        
        session = URLSession(configuration: config)
        let url = URL(string: "http://viacep.com.br/ws/01538000/json/")
        print(url!)
        let task = session?.dataTask(with: url!, completionHandler: { (data, response, error) in
            // ações que serão efetuadas qunado
            // a execução da task se completa
            let texto = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print(texto!)
            
            if let ende = self.retornaEnderecoCEP(data: data!){
                DispatchQueue.main.async {
                    self.ender.text = ende
                }
            }
        })
        // a ln abaixo dispara a execução da task
        task?.resume()
    }
    
    func retornaEnderecoCEP(data: Data) -> String? {
        var resposta:String?=nil
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            if let ender = json["logradouro"] as? String{
                resposta = ender
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

