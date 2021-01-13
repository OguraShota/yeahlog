![headerlogo](https://user-images.githubusercontent.com/73694913/104428553-f740bd00-55c7-11eb-8935-0c57a0694f78.png)


## 概要
![image](https://user-images.githubusercontent.com/73694913/104434513-a6809280-55ce-11eb-8267-fadf970edc37.png)

## URL
 [yeahlog](http://3.131.23.59 "yeahlog")<br>
 
 【ゲストログイン】ボタンからテストユーザーとしてログインできま
 
## 制作背景

前職が不動産賃貸の営業時代、会社の課題となっていたのが短期解約を減らすことでした。  
その為に営業マンは実際に物件を確認し、家主からもお話を伺うようにしているのですが、実際の入居者しか知らない物件のマイナスポイントまで把握する事は難しかったです。  
例えば夜間の騒音や入居者間のトラブル、設備の不具合など色々な情報を事前に知ることができれば少しでも入居後のギャップを減らすことができるのではないかと考え、気になった


## 工夫したポイント
・RSpecでModel,Request,Systemテスト記述  
・Ajaxを用いた非同期処理(フォロー/未フォロー)    

## アプリケーションの機能
・自分の住んでる物件を投稿  
・フォロー  
・お気に入り登録
・コメント  
・通知
・検索(Ransack)  
・ログイン  
・ログイン状態の保持  
・モデルに対するバリデーション

## 環境・使用技術
■フロントエンド  
・Bootstrap
・SCSS
・JavaScript、jQuery、Ajax

■フレームワーク  
・Ruby on Rails
 
■開発環境    
・MySQL
 
■本番環境  
・AWS (EC2)
・Nginx
・Capistrano
