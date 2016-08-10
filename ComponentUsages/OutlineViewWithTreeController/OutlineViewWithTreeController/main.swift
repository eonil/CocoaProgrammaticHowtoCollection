import Cocoa

final class Band: NSObject
{
    init(title: String, songs: [String]) {
        self.title = title
        for song in songs {
            self.songs.append(Song(song))
        }
    }
    
    var title : String
    var isSong = false
    var songs: [Song] = []
    
    func childNodes() -> AnyObject? {
        return songs;
    }
}

final class Song : NSObject
{
    init(_ title: String) {
        self.title = title
    }
    
    var title : String
    var isSong = true
    
    func childNodes() -> AnyObject? {
        return nil
    }
    
}

final class DataContext: NSObject
{
    var playlist : [Band] = [
        Band(title: "Wham", songs: ["Last Christmas", "Wake me up"]),
        Band(title: "Beatles", songs: ["My Sweet Krishna", "Mister Postman","Seventeen"])
    ]
    
}

final class ExampleOutlineViewController : NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate {
    
    let scrollView = NSScrollView()
    let	outlineView	= NSOutlineView()
    let column = NSTableColumn(identifier: "DataCell")
    let treeController = NSTreeController()
    let dataContext = DataContext()
    
    override func loadView() {
        
        configure(column)
        configure(outlineView)
        configure(treeController)
        
        treeController.bind(NSContentArrayBinding,
                            toObject: dataContext,
                            withKeyPath: "playlist",
                            options: nil)
        
        outlineView.bind(NSContentBinding   ,
                         toObject: treeController,
                         withKeyPath: "arrangedObjects",
                         options: nil)
        
        column.bind(NSValueBinding,
                    toObject: treeController,
                    withKeyPath: "arrangedObjects.title",
                    options: nil)
        
        scrollView.documentView = outlineView
        self.view = scrollView
    }
    
    private func configure(column: NSTableColumn)
    {
        column.width = 250
        column.title = "Song title"
    }
    
    private func configure(outlineView: NSOutlineView)
    {
        outlineView.addTableColumn(column)
        outlineView.outlineTableColumn = column
    }
    
    private func configure(treeController: NSTreeController) {
        treeController.childrenKeyPath = "childNodes"
        treeController.leafKeyPath = "isSong"
    }
    
    func outlineView(outlineView: NSOutlineView,
                     viewForTableColumn tableColumn: NSTableColumn?,
                     item: AnyObject) -> NSView? {
        
        let columnIdentifier = tableColumn!.identifier
        
        // Use recycled NSTableCellViews if available
        if let cell = outlineView.makeViewWithIdentifier(columnIdentifier, owner: self) as? NSTableCellView {
            return cell
        }
        
        let rowHeight = outlineView.rowHeight
        let frameSize = NSMakeRect(0, 0, tableColumn!.width, rowHeight)
        
        // It is necessary to specify frame size, otherwise, its default 
        // (0, 0, 0, 0) and will not be visible
        let cv = NSTableCellView(frame: frameSize)
        cv.identifier = "DataCell"
 
        let tf = NSTextField()
        cv.textField = tf
        cv.addSubview(tf)
        
        return cv
    }
}


///	MARK:
final class ApplicationController: NSObject, NSApplicationDelegate {
    let	window1	=	NSWindow()
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        window1.contentViewController		=	ExampleOutlineViewController()
        
        window1.styleMask					=	NSResizableWindowMask | NSTitledWindowMask | NSClosableWindowMask
        window1.setFrame(CGRect(x: 0, y: 0, width: 800, height: 500), display: false)
        
        window1.makeKeyAndOrderFront(self)
        
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true;
    }
    
}

autoreleasepool { () -> () in
    let	app1		=	NSApplication.sharedApplication()
    let	con1		=	ApplicationController()
    
    app1.delegate	=	con1
    app1.run()
}
