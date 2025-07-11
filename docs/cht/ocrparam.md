# OCR自動化執行方法

爲了適應不同的遊戲的不同的文本刷新方式，軟件有四種不同的方式來進行自動地以一定的頻率從遊戲中進行截圖。

## 週期執行

::: tip
如果你無法理解其他設置的參數，那麼請使用這種方式，這種方式是最簡單的方式。
:::

這個方法會依據“執行週期”來週期執行。

## 分析圖像更新

這個方法會使用參數“圖像穩定性閾值”“圖像一致性閾值”

1. #### 圖像穩定性閾值

    當遊戲文本不是立即出現（文本速度不是最快），或者遊戲有動態背景或live2d時，截取的圖片是會不停的發生變化的。

    每次截圖時，和上一次截圖進行比較，計算相似度。當相似度大於閾值時，認爲圖片是處於穩定狀態，進行下一步判斷。

    如果可以確定遊戲是完全靜態的，可以將這個值設置爲0，反之可以適當提高該值。

1. #### 圖像一致性閾值

    這個參數是最重要的。

    當圖片穩定後，比較當前圖片和上一次進行OCR時圖片（而非上一次截圖）的相似度。當相似度小於該閾值時，認爲遊戲文本發生了變化，進行OCR。

    如果OCR頻率過快，可以適當提高該值；反之如果太過遲鈍，可以適當降低該值。

## 鼠標鍵盤觸發+等待穩定


1. #### 觸發事件

    默認以下鼠標鍵盤事件將觸發該方法：按下鼠標左鍵、按下Enter、鬆開Ctrl、鬆開Shift、鬆開Alt。如果綁定了遊戲窗口，則僅當遊戲窗口爲前臺窗口時，纔會觸發方法。

    觸發該方法後，由於需要等待遊戲渲染新的文本，或文本可能不是立即出現（文本速度不是最快），因此需要稍微等待一小段時間，直到顯示的文本穩定。

    觸發該方法並穩定後，一定會進行翻譯，不會考慮文本的相似度。

    如果文本速度是最快的，則可以將以下兩個參數都設置爲0。否則，判斷需要等待的時間需要以下參數：

1. #### 延遲(s)

    等待一個固定的延遲時間（內置有0.1s的固有延遲時間，以滿足遊戲引擎的內部邏輯處理）。

1. #### 圖像穩定性閾值

    這個值和上面的同名參數類似。不過這個僅用來判定文本是否繪製完畢，因此和上面的同名參數不共用配置。

    由於慢速文本的繪製時間不固定，因此使用指定的固定延遲可能不能滿足需要。當圖像與上次截圖相似度大於閾值時，執行本次觸發事件。


## 文本相似度閾值

OCR的結果是不穩定的，經常對於圖片的微小擾動會使文本發生微小變化，導致翻譯也會連帶重新翻譯。

每次調用OCR後，都會比較本次OCR的結果和上一次OCR的結果（編輯距離），當編輯距離大於閾值時，纔會輸出文本。

