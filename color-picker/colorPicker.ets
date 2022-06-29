/*
* Copyright (c) 2022 Application Library Engineering Group.
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import { DialogExample } from '@ohos/color-picker'

@CustomDialog
export struct MainPage {
  @State col: string = '#ff0000'
  @State h: number = 0
  @State s: number = 100
  @State l: number = 50
  @State ColorFromGradient: string = '#ff0000'
  @State ColorFromS: string = '#ff0000'
  @State SliderS: number= 100
  @State SliderL: number = 50
  @State OpacityOne: number = 1
  dialogController: CustomDialogController = new CustomDialogController({
    builder: DialogExample({ action: (value) => this.onAccept(value) }),
    cancel: this.existApp,
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
  });
  controller: CustomDialogController;
  action: (string) => void;

  onAccept(value: number) {
    this.OpacityOne = 1
    this.h = value;
    this.SliderS = 100
    this.SliderL = 50
    var a = this.HSLToRGB(this.h, this.SliderS, this.SliderL)
    var b = this.rgbToHex(a[0], a[1], a[2])
    this.ColorFromS = b
    this.ColorFromGradient = b
    this.col = b
    console.log(this.col)
  }

  existApp() {
    this.OpacityOne = 1
    console.log("Cancel dialog!");
  }

  rgbToHex(r, g, b) {
    return "#" + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1);
  }

  HSLToRGB(h, s, l) {
    s /= 100;
    l /= 100;
    const k = n => (n + h / 30) % 12;
    const a = s * Math.min(l, 1 - l);
    const f = n =>
    l - a * Math.max(-1, Math.min(k(n) - 3, Math.min(9 - k(n), 1)));
    return [Math.round(255 * f(0)), Math.round(255 * f(8)), Math.round(255 * f(4))];
  }

  build() {
    Column() {
      Column() {
        Row() {
          Flex({ justifyContent: FlexAlign.SpaceEvenly }) {
            Button('Selection of Color')
              .width(250)
              .height(50)
              .fontSize(22)
              .backgroundColor(Color.White)
              .fontColor(this.col)
              .fontWeight(FontWeight.Bolder)
              .onClick(() => {
                this.OpacityOne = 0.2
                this.dialogController.open()
              })

            Button('OK')
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bolder)
              .backgroundColor(0XE0E1E4)
              .onClick(() => {
                this.controller.close();
                this.action(this.col);
                console.log(this.col)
              })
          }
        }
        .backgroundColor('#c2b7bf')
        .height(70)
        .borderRadius(20)

        Row()
          .height(20)
        Row()
          .height('40%')
          .width('340')
          .linearGradient({
            angle: 90,
            direction: GradientDirection.Left,
            colors: [[Color.Red, 0], [Color.Yellow, 1 / 6], [0x00FF00, 2 / 6], [0x00FFFF, 3 / 6], [Color.Blue, 4 / 6], [0xFF00FF, 5 / 6], [Color.Red, 1]]
          })
          .onClick((event: ClickEvent) => {
            this.h = (event.x / 340) * 360;
            this.SliderS = 100
            this.SliderL = 50
            this.s = 100
            this.l = 50
            var a = this.HSLToRGB(this.h, this.SliderS, this.SliderL)
            var b = this.rgbToHex(a[0], a[1], a[2])
            this.col = b
            this.ColorFromGradient = b
            this.ColorFromS = b
            console.log(this.col)
          })
        Row()
          .height(40)
        Flex({ justifyContent: FlexAlign.Start }) {
          Text("Saturation :").fontWeight(FontWeight.Bolder).fontSize(15)
        }

        Row({ space: 5 }) {
          Slider({
            value: this.SliderS,
            min: 0,
            max: 100,
            style: SliderStyle.OutSet
          })
            .blockColor(Color.Blue)
            .trackColor(Color.Gray)
            .selectedColor(Color.Blue)
            .showSteps(true)
            .showTips(true)
            .trackThickness(5)
            .onChange((value: number, mode: SliderChangeMode) => {
              this.SliderS = value
              var a = this.HSLToRGB(this.h, this.SliderS, this.SliderL)
              var b = this.rgbToHex(a[0], a[1], a[2])
              this.ColorFromS = b
              this.col = b
              console.log(this.col)
            })
        }
        .width('100%')

        Row()
          .width(340)
          .height('5%')
          .borderRadius(20)
          .linearGradient({
            angle: 90,
            colors: [[0x808080, 0], [this.ColorFromGradient, 1]]
          })
        Row()
          .height(40)
        Flex({ justifyContent: FlexAlign.Start }) {
          Text("Lightness :").fontWeight(FontWeight.Bolder).fontSize(15)
        }

        Row({ space: 5 }) {
          Slider({
            value: this.SliderL,
            min: 0,
            max: 100,
            style: SliderStyle.OutSet
          })
            .blockColor(Color.Blue)
            .trackColor(Color.Gray)
            .selectedColor(Color.Blue)
            .showSteps(true)
            .showTips(true)
            .trackThickness(5)
            .onChange((value: number, mode: SliderChangeMode) => {
              this.SliderL = value
              var a = this.HSLToRGB(this.h, this.SliderS, this.SliderL)
              var b = this.rgbToHex(a[0], a[1], a[2])
              this.col = b
              console.log(this.col)
            })
        }
        .width('100%')

        Row()
          .width(340)
          .height('5%')
          .borderRadius(20)
          .linearGradient({
            angle: 90,
            colors: [[Color.Black, 0], [this.ColorFromS, 1 / 2], [Color.White, 1]]
          })
        Row()
          .height(30)
        Row({ space: 15 }) {
          Text("Hex Color Code:").fontWeight(FontWeight.Bolder).fontSize(20)
          Text(this.col).fontWeight(FontWeight.Bolder).fontColor(this.col).fontSize(25)
        }
      }
      .padding({ right: '2%', left: '2%', top: '1%' })
    }
    .opacity(this.OpacityOne)
    .height('120%')
  }
}

export { DialogExample } from './colorDialog'