# iOS-Learning-6.30

A Simple iOS project for self-study.

记录一些开发过程中遇到的坑点

设置边框样式，只有设置了才会显示边框样式  
text.borderStyle = UITextBorderStyleRoundedRect;




关于视图布局的注意事项

某些用来展现内容的用户控件，例如文本控件UILabel、按钮UIButton、图片视图UIImageView等，它们具有自身内容尺寸（Intrinsic Content Size），此类用户控件会根据自身内容尺寸添加布局约束。也就是说，如果开发者没有显式给出其宽度或者高度约束，则其自动添加的自身内容约束将会起作用。

对于模态视图
ipad应用有更多样式（背景变黑等），而iphone只有一种

对于plist文件读取
1、用文件新建和代码新建的读取文件路径方式不同
2、writeToFile时数据类型需保持一致（或者需要为字典？ 没验证）
