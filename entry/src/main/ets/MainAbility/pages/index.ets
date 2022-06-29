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

import { MainPage } from '@ohos/color-picker'

@Entry
@Component
struct Index {
  @State FinalColor: string = "xxxxxx"
  dialogController: CustomDialogController = new CustomDialogController({
    builder: MainPage({ action: (value) => this.onAccept(value) }),
    cancel: this.existApp,
    autoCancel: true,
    alignment: DialogAlignment.Center,
  });

  existApp() {
    console.log("Cancel dialog!");
  }

  onAccept(value: string) {
    console.log(value)
    this.FinalColor = value
  }

  build() {
    Column({ space: 20 }) {
      Row() {
        Flex({ justifyContent: FlexAlign.SpaceEvenly }) {
          Button('Color Picker')
            .height(60)
            .fontSize(20)
            .fontWeight(FontWeight.Bolder)
            .backgroundColor(Color.White)
            .fontColor(this.FinalColor)
            .onClick(() => {
              this.dialogController.open();
            })
        }
      }
      .width('100%')
      .backgroundColor('#c2b7bf')
      .height(70)

      Text("Hex-Code of Selected Color = " + this.FinalColor)
        .fontSize(15)
        .fontWeight(FontWeight.Bolder)
    }
    .alignItems(HorizontalAlign.Center)
    .margin({ top: 30 })
  }
}


