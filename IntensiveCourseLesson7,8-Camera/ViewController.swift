//
//  ViewController.swift
//  IntensiveCourseLesson7,8-Camera
//
//  Created by 相良 詠斗 on 2021/04/04.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var pictureImage: UIImageView!
    
    //カメラを起動するをタップすると実行
    @IBAction func cameraButtonAction(_ sender: Any) {
//        //カメラが利用可能かチェック
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            print("カメラは利用できます")
//            //(1)UIImagePickerControllerのインスタンスを作成
//            let imagePickerController = UIImagePickerController()
//            //(2)souurceTypeにcameraを設定
//            imagePickerController.sourceType = .camera
//            //(3)delegate設定
//            imagePickerController.delegate = self
//            //(4)モーダルビューで表示
//            present(imagePickerController, animated: true, completion: nil)
//        } else {
//            print("カメラは利用できません")
//        }
        
//        //カメラかフォトライブラリーどちらから画像を取得するか選択
//        let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
//        
//        //カメラを起動するための選択肢を定義
//        let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: nil)
//        alertController.addAction(cameraAction)
//        
//        //フォトライブラリーを起動するための選択肢を定義
//        let photoLibraryAction = UIAlertAction(title: "フォトライブラリー", style: .default, handler: nil)
//        alertController.addAction(photoLibraryAction)
    
        //カメラかフォトライブラリーどちらから画像を取得するか選択
        let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
        
        //カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            //カメラを起動するための選択肢を定義
            let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: { (action) in
                //カメラを起動
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
                
            })
            alertController.addAction(cameraAction)
        }
        
        //フォトライブラリーが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            //フォトライブラリーを起動するための選択肢を定義
            let photoLibraryAction = UIAlertAction(title: "フォトライブラリー", style: .default, handler: { (action) in
                //フォトライブラリーを起動
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
                
            })
            alertController.addAction(photoLibraryAction)
        }
        
        //キャンセルの選択肢を定義
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        //iPadで落ちてしまう対策
        alertController.popoverPresentationController?.sourceView = view
        
        //選択肢を画面に表示
        present(alertController, animated: true, completion: nil)
        
    }
    
//    @IBAction func shareButtonAction(_ sender: Any) {
//        //表示画面をアンラップしてシェア画像を取り出す
//        if let shareImage = pictureImage.image {
//            //UIActivityViewControllerに渡す配列を作成
//            let shareItems = [shareImage]
//            //UIActivityViewControllerにシェア画像を渡す
//            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
//            //iPadで落ちてしまう対策
//            controller.popoverPresentationController?.sourceView = view
//            //UIActivityViewControllerを表示
//            present(controller, animated: true, completion: nil)
//        }
//    }
    
    //(1)撮影が終わったときに呼ばれるdelegateメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        //(2)撮影した画像を配置したpictureImageに渡す
//        pictureImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//        //(3)モーダルビューを閉じる
//        dismiss(animated: true, completion: nil)
        
        //(2)撮影した画像を配置したcaptureImageに渡す
        captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        //(3)モーダルビューを閉じる
        dismiss(animated: true, completion: {
            //(4)エフェクト画面に遷移
            self.performSegue(withIdentifier: "showEffectView", sender: nil)
        })
        
    }
    
    //次の画面遷移するときに渡す画像を格納する場所
    var captureImage : UIImage?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面のインスタンスを格納
        if let nextViewControlller = segue.destination as? EffectViewController {
            //次の画面のインスタンスに取得した画像を渡す
            nextViewControlller.originalImage = captureImage
        }
    }
    
}

