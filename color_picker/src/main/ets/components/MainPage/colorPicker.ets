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

import colorDialog  from './colorDialog'
import router from '@system.router'

@Entry
@Component
struct colorPicker {
  private model: colorPicker.Model = new colorPicker.Model()
  @State FinalColor: string = '#ff0000'
  @State hue: number = 0
  @State ColorFromGradient: string = '#ff0000'
  @State ColorFromS: string = '#ff0000'
  @State SliderSaturation: number= 100
  @State SliderLightness: number = 50
  @State OpacityOne: number = 1
  dialogController: CustomDialogController = new CustomDialogController({
    builder: colorDialog({ action: (value) => this.onAccept(value) }),
    cancel: this.existApp,
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
  });

  onAccept(value: number) {
    this.OpacityOne = 1
    this.hue = value;
    this.SliderSaturation = 100
    this.SliderLightness = 50
    var RGBPixels = this.HSLToRGB(this.hue, this.SliderSaturation, this.SliderLightness)
    var HEXCode = this.rgbToHex(RGBPixels[0], RGBPixels[1], RGBPixels[2])
    this.ColorFromS = HEXCode
    this.ColorFromGradient = HEXCode
    this.FinalColor = HEXCode
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
              .width('250vp')
              .height('50vp')
              .fontSize('22fp')
              .backgroundColor(Color.White)
              .fontColor(this.FinalColor)
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
                console.log(this.FinalColor)
                router.back()
              })
          }
        }
        .backgroundColor('#c2b7bf')
        .height('70vp')
        .borderRadius('20vp')

        Row()
          .height('20vp')
        Row()
          .height('40%')
          .width('340vp')
          .linearGradient({
            angle: 90,
            direction: GradientDirection.Left,
            colors: [[Color.Red, 0], [Color.Yellow, 1 / 6], [0x00FF00, 2 / 6], [0x00FFFF, 3 / 6], [Color.Blue, 4 / 6], [0xFF00FF, 5 / 6], [Color.Red, 1]]
          })
          .onClick((event: ClickEvent) => {
            this.hue = (event.x / 340) * 360;
            this.SliderSaturation = 100
            this.SliderLightness = 50
            var RGBPixels = this.HSLToRGB(this.hue, this.SliderSaturation, this.SliderLightness)
            var HEXCode = this.rgbToHex(RGBPixels[0], RGBPixels[1], RGBPixels[2])
            this.FinalColor = HEXCode
            this.ColorFromGradient = HEXCode
            this.ColorFromS = HEXCode
          })
        Row()
          .height('40vp')
        Flex({ justifyContent: FlexAlign.Start }) {
          Text("Saturation :").fontWeight(FontWeight.Bolder).fontSize('15fp')
        }

        Row({ space: '5vp' }) {
          Slider({
            value: this.SliderSaturation,
            min: 0,
            max: 100,
            style: SliderStyle.OutSet
          })
            .blockColor(Color.Blue)
            .trackColor(Color.Gray)
            .selectedColor(Color.Blue)
            .showSteps(true)
            .showTips(true)
            .trackThickness('5vp')
            .onChange((value: number, mode: SliderChangeMode) => {
              this.SliderSaturation = value
              var RGBPixels = this.HSLToRGB(this.hue, this.SliderSaturation, this.SliderLightness)
              var HEXCode = this.rgbToHex(RGBPixels[0], RGBPixels[1], RGBPixels[2])
              this.ColorFromS = HEXCode
              this.FinalColor = HEXCode
            })
        }
        .width('100%')

        Row()
          .width('340vp')
          .height('5%')
          .borderRadius('20vp')
          .linearGradient({
            angle: 90,
            colors: [[0x808080, 0], [this.ColorFromGradient, 1]]
          })
        Row()
          .height('40vp')
        Flex({ justifyContent: FlexAlign.Start }) {
          Text("Lightness :").fontWeight(FontWeight.Bolder).fontSize('15fp')
        }

        Row({ space: '5vp' }) {
          Slider({
            value: this.SliderLightness,
            min: 0,
            max: 100,
            style: SliderStyle.OutSet
          })
            .blockColor(Color.Blue)
            .trackColor(Color.Gray)
            .selectedColor(Color.Blue)
            .showSteps(true)
            .showTips(true)
            .trackThickness('5vp')
            .onChange((value: number, mode: SliderChangeMode) => {
              this.SliderLightness = value
              var RGBPixels = this.HSLToRGB(this.hue, this.SliderSaturation, this.SliderLightness)
              var HEXCode = this.rgbToHex(RGBPixels[0], RGBPixels[1], RGBPixels[2])
              this.FinalColor = HEXCode
            })
        }
        .width('100%')

        Row()
          .width('340vp')
          .height('5%')
          .borderRadius('20vp')
          .linearGradient({
            angle: 90,
            colors: [[Color.Black, 0], [this.ColorFromS, 1 / 2], [Color.White, 1]]
          })
        Row()
          .height('30vp')
        Row({ space: '15vp' }) {
          Text("Hex Color Code:").fontWeight(FontWeight.Bolder).fontSize('20fp')
          Text(this.FinalColor).fontWeight(FontWeight.Bolder).fontColor(this.FinalColor).fontSize('25fp')
        }
      }
      .padding({ right: '2%', left: '2%', top: '1%' })
    }
    .opacity(this.OpacityOne)
    .height('100%')
  }
}

namespace colorPicker {
  export class Model {
  }
}

export default colorPicker;
