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

import router from '@system.router';

@Entry
@Component
struct Index {
  build() {
    Column() {

      Column({ space: '20vp' }) {
        Row() {
          Flex({ justifyContent: FlexAlign.SpaceEvenly }) {
            Button('Color Picker')
              .height('60vp')
              .fontSize('20fp')
              .fontWeight(FontWeight.Bolder)
              .backgroundColor(Color.White)
              .fontColor(Color.Black)
              .onClick(() => {
                router.push({ uri: "pages/colorPickerUI" })
              })
          }
        }
        .width('100%')
        .backgroundColor('#c2b7bf')
        .height('70vp')
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ top: '30vp' })
    }
  }
}
