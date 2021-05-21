
import UIKit

class SubjectsViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
          print("Count subjects : \(SubjectService.currentSubjectList.count)")
    }
    
    @IBAction func btnDashBoard(_ sender: Any) {
        //Navigates to the dshboard page.
        let destinationView = self.storyboard?.instantiateViewController(withIdentifier: "LandingPageViewController") as! LandingPageViewController
        
        present(destinationView, animated:true, completion: nil);
    }
    
    let tableview: UITableView = {
        let tv = UITableView();
        tv.backgroundColor = UIColor.clear
        tv.separatorColor = UIColor.clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        return tv;
    }()
    
    func setupTableView(){
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        view.addSubview(tableview)
        
        tableview.register(ModelForTableCell.self, forCellReuseIdentifier: "cellId")
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
            
        ]);
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return SubjectService.currentSubjectList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 2
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ModelForTableCell
        cell.backgroundColor = UIColor.clear
        cell.tableCellLevelInstance.text = "\(SubjectService.currentSubjectList[indexPath.row].Code) - \(SubjectService.currentSubjectList[indexPath.row].Name)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
