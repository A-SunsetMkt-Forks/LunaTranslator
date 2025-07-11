# 根據不同的人物使用不同的聲音

首先，如果當前文本沒有人名之類的東西，那麼可以在文本選擇器中，額外選擇人名的文本。顯示的文本將按照選擇的先後順序進行排列。

然後，在遊戲設置->`語音`（或者設置界面的`語音設置`，但這樣將是全局的設置，不建議進行全局設置）中，取消`跟隨默認`，然後激活`語音指定`，在其設置中添加一行，將`條件`設置爲`包含`，`目標`中填入人名，然後在`指定爲`中選擇語音。

![img](https://image.lunatranslator.org/zh/tts/1.png) 

但是，由於額外選擇了人名文本，使得顯示和翻譯的內容多出了人名的內容，且語音也會把人名讀出來。爲了解決這個問題，我們激活`語音修正`，在其中利用正則表達式，將人名及其符號過濾掉。

## 語音指定的具體解釋

噹噹前文本符合條件時，則執行`指定爲`中所指定的動作

#### 條件

1. 正則
    判斷時，是否使用正則表達時進行判斷。
1. 條件
    **首尾** 當爲首尾時，僅當目標處於文本的首尾位置時，才符合判定
    **包含** 只要目標出現在文本中，就符合判斷。這個是更寬鬆的判定。
    當同時激活`正則`時，會自動處理正則表達式以兼容該選項。
1. 目標
    用於判定的文本，通常爲**人名**。
    當激活`正則`時，其中的內容將作爲正則表達式來實現更準確的判定。

#### 指定爲

1. 跳過
    當判定爲符合條件時，跳過對當前文本的朗讀

1. 默認
    對符合條件的內容，使用默認語音進行朗讀。通常，當使用了一個非常寬鬆的判定時，容易誤傷。將設置爲該動作的判定移動到更寬鬆的判定以前，可以避免誤傷
1. 選擇語音
    選擇後將彈出一個窗口，選擇語音引擎和語音。符合條件時將使用該語音進行朗讀。
