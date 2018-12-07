# -*- coding: utf-8 -*-
import wx

def main():
    app = wx.App()
    frame = MyFrame("薪資試算程式", (100, 150), (320, 240))
    frame.Show()
    app.MainLoop()

class MyFrame(wx.Frame):

    def __init__(self, title, pos, size):
        super(MyFrame, self).__init__(None, -1, title, pos, size)
        panel = wx.Panel(self)
        wx.StaticText(parent = panel, label = u"工作幾年？", pos = (10, 10))
        self.year = wx.TextCtrl(parent = panel, pos = (100, 10))
        wx.StaticText(parent = panel, label = u"一個月多少錢？", pos = (10, 50))
        self.money = wx.TextCtrl(parent = panel, pos = (100, 50))
        btn = wx.Button(parent = panel, label = u"結算薪資", pos = (10, 100))
        self.Bind(wx.EVT_CLOSE, self.OnCloseWin)
        btn.Bind(wx.EVT_BUTTON, self.OnClick)

    def OnClick(self, event):
        year = int(self.year.GetValue())
        money = int(self.money.GetValue())
        total = year * 12 * money
        str = "您工作期間總收入為: {}".format(total)
        wx.MessageBox(str, "提示訊息")

    def OnCloseWin(self, event):
        dlg = wx.MessageDialog(None, "您確定要關閉程式嗎 ?", "提示訊息", wx.YES_NO)
        result = dlg.ShowModal()
        if result == wx.ID_YES:
            self.Destroy()

if __name__ == "__main__":
    main()
