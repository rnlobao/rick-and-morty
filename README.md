# Listagem de personagens de Rick And Morty

Projeto de uma entrevista técnica feita em que consistia em alguns desafios como:

- Criação de uma tela de Splash
- Tela de listagem de personagens
- Uma tela de detalhes
- Alamofire para realizar requisições
- Testes unitários

Além disso também foi feito:

- Gerenciador de dependências
- Paginação das requisições
- Arquitetura MVVM
- Criação totalmente em ViewCode
- Injeção de dependências

Essa é API pública do desafio: https://rickandmortyapi.com/api/


## 1. Integração API Restful
Inicialmente averiguei que o retorno do serviço eram 3 novas URL e que a que eu queria era a dos Characters:

<div align="center">
  <img width="300" alt="image" src="https://github.com/rnlobao/rick-and-morty/assets/66230142/09ae7859-caf8-470d-aaad-3aa250ffe5e8">
</div>

Fiz então uma requisição dupla como visto no Network Service, inicialmente requisitando as APIs com o Model apropriado:
```Swift
func getCharacterData(completionHandler: @escaping (_ result: Result<Characters, NetworkError>) -> Void) {
        guard let urlString = URL(string: NetworkConstants.shared.geralUrl) else { return }

        AF.request(urlString).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let userResponse = try JSONDecoder().decode(AllUrls.self, from: data!)
                    self.getDataFromURLGiven(url: userResponse.characters) { result in
                        completionHandler(result)
                    }
                    
                } catch {
                    completionHandler(.failure(.canNotParseData))
                }
                
            case .failure(_):
                completionHandler(.failure(.canNotParseData))
            }
        }
    }
```

E depois uma chamada que posteriormente serviria também para a paginação:
```Swift
func getDataFromURLGiven(url: String, completionHandler: @escaping (_ result: Result<Characters, NetworkError>) -> Void) {
        guard let urlString = URL(string: url) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        AF.request(urlString).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let userResponse = try JSONDecoder().decode(Characters.self, from: data!)
                    completionHandler(.success(userResponse))
                    
                } catch {
                    completionHandler(.failure(.canNotParseData))
                }
                
            case .failure(_):
                completionHandler(.failure(.canNotParseData))
            }
        }
    }
```

### 1.1 Paginação
A paginação basicamente chama a segunda função de personagens quando há uma nextPage nas Infos da model e quando chega a certa distância da boarda da tableView:

```Swift
func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (mainTableView.contentSize.height-100-scrollView.frame.size.height) {
            guard viewModel.shouldLoadMoreInfo, !viewModel.isLoadingMoreCharacters else { return }
            let spinner = createSpinnerFooter()
            self.mainTableView.tableFooterView = spinner
            viewModel.getAdditionalData(urlString: viewModel.apiInfo?.next ?? "")
        } else {
            mainTableView.tableFooterView = UIView(frame: CGRect.zero)
        }
    }
```

## 2. Injeção de dependência
Deixei de criar as dependências da viewModel dentro da classe, o que facilitou os testes unitários posteriormente:
```Swift
init(delegate: RickAndMortyDelegate? = nil, service: NetworkServicing) {
  self.delegate = delegate
  self.service = service
}
```

## 3. Testes unitários
Foi criado um mock conformando com o protocolo da chamada de serviço para facilitar os testes

```Swift
var viewModel: MainViewModel!
let mockedService = NetworkServiceMock()

override func setUp() {
  super.setUp()
  viewModel = MainViewModel(service: mockedService)
}

func testGetDataSuccess() {
  viewModel.getData()
  XCTAssertEqual(viewModel.characters.count, 4)
}
```

## 4. Telas

Splash | Tela de detalhes | Paginação
  :---------: | :---------: | :---------:
  <img width="200" alt="image" src="https://github.com/rnlobao/rick-and-morty/assets/66230142/7be2f04e-5524-40aa-9fec-792b24397cad"> | <img width="200" alt="image" src="https://github.com/rnlobao/rick-and-morty/assets/66230142/ad0746ae-0b6a-4a84-ba12-934d8582ba26"> | <img width="200" alt="image" src="https://github.com/rnlobao/rick-and-morty/assets/66230142/4233eee4-ed30-4901-aea3-6fe36e47d985"> 



