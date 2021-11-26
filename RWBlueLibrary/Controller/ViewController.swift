

import UIKit

final class ViewController: UIViewController {
  
  // Здесь вы создаете перечисление, которое действует как контейнер для ваших констант.
  
  private enum Constants {
    static let CellIdentifier = "Cell"
  }
  
  private var currentAlbumIndex = 0
  private var currentAlbumData: [AlbumData]?
  private var allAlbums = [Album]()

  @IBOutlet var tableView: UITableView!
  @IBOutlet var undoBarButtonItem: UIBarButtonItem!
  @IBOutlet var trashBarButtonItem: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    allAlbums = LibraryApi.shared.getAlbums()
    tableView.dataSource = self
    showDataForAlbum(at: currentAlbumIndex)
  }
  
  private func showDataForAlbum(at index: Int) {
      
    // defensive code: make sure the requested index is lower than the amount of albums
    if (index < allAlbums.count && index > -1) {
      // fetch the album
      let album = allAlbums[index]
      // save the albums data to present it later in the tableview
      currentAlbumData = album.tableRepresentation
    } else {
      currentAlbumData = nil
    }
    // we have the data we need, let's refresh our tableview
    tableView.reloadData()
  }

}

extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let albumData = currentAlbumData else {
      return 0
    }
    return albumData.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier, for: indexPath)
    if let albumData = currentAlbumData {
//      let row = indexPath.row
//      задеприкеченыые свойства, больше не используются
      cell.textLabel?.text = albumData[indexPath.row].title
      cell.detailTextLabel?.text = albumData[indexPath.row].value
    }
    return cell
  }
}
