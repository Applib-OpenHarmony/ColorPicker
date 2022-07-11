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

@CustomDialog
struct colorDialog {
  @State hue: number = 0
  @State saturation: number = 100
  @State lightness: number = 50
  @State FinalColor: string = '#ff0000'
  controller: CustomDialogController;
  action: (number) => void;

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
      Flex({ justifyContent: FlexAlign.SpaceEvenly }) {
        Button('OK')
          .width('60vp')
          .height('40vp')
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bolder)
          .backgroundColor(0XE0E1E4)
          .onClick(() => {
            this.controller.close();
            this.action(this.hue);
          })
        Text(this.FinalColor).fontWeight(FontWeight.Bolder).fontSize('25fp').fontColor(this.FinalColor)
      }

      Row()
        .height('20vp')
      Row()
        .height('50%')
        .width('340vp')
        .linearGradient({
          angle: 90,
          direction: GradientDirection.Left,
          colors: [[Color.Red, 0], [Color.Yellow, 1 / 6], [0x00FF00, 2 / 6], [0x00FFFF, 3 / 6], [Color.Blue, 4 / 6], [0xFF00FF, 5 / 6], [Color.Red, 1]]
        })
        .onClick((event: ClickEvent) => {
          this.hue = (event.x / 340) * 360;
          this.saturation = 100
          this.lightness = 50
          var RGBPixels = this.HSLToRGB(this.hue, this.saturation, this.lightness)
          var HEXCode = this.rgbToHex(RGBPixels[0], RGBPixels[1], RGBPixels[2])
          this.FinalColor = HEXCode
        })
      Row()
        .height('30vp')
    }
    .margin({ top: '5vp' })
  }
}

export default colorDialog
