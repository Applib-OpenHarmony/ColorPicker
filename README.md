# ColorPicker
Color Picker in OpenHarmony

 ![colorPicker](screenshots/ColorPickerAnimation.gif)
 


## Download & Install
Install using npm

```npm i @ohos/color_picker```

Details about OpenHarmony NPM environment configuration, see at [here](https://gitee.com/openharmony-tpc/docs/blob/master/OpenHarmony_npm_usage.md)


## Usage Instructions
1. Import files and code dependencies
```
import { colorPicker }  from '@ohos/color_picker'
```
2. Initialize ColorPicker model data
```
private model: colorPicker.Model = new colorPicker.Model()
```
3. Code for creating ColorPicker Screen
```
  private model: colorPicker.Model = new colorPicker.Model()
  build() {
    Column() {
      colorPicker({ model: this.model })
    }
  }
  ```
  
 ![colorPicker](screenshots/colorPicker.png)
  
4. Code for creating colorDialog Screen
```
dialogController: CustomDialogController = new CustomDialogController({
    builder: colorDialog({ action: (value) => this.onAccept(value) }),
    cancel: this.existApp,
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
  });

  onAccept(value: number) {
    this.h = value;
    var a = this.HSLToRGB(this.h, this.SliderS, this.SliderL)
    var b = this.rgbToHex(a[0], a[1], a[2])
  }

  existApp() {
    this.OpacityOne = 1
    console.log("Cancel dialog!");
  }
  ```

 ![colorPicker](screenshots/colorDialog.png)



### Use Cases
1. Use the button **Color Picker** to open the ColorPicker Screen .

2. In ColorPicker Screen, use button **Selection of Color** to open the customDialog and choose the main color.

3. Change **Saturation** and **Lightness** to choose any variation of that main color.

4. On pressing **OK**, HEX-Code of selected color will be printed in previewer log.



## Directory Structure
```
|---- ColorPicker (Project Name)
|     |---- color_picker (Color Picker Library)
|           |---- src
|                 |---- main
|                       |---- ets
|                             |----components
|                                   |---- MainPage
|                                         |---- colorDialog.ets
|                                         |---- colorPicker.ets
|           |---- index.ets
|
|     |---- entry
|           |---- src
|                 |---- main
|                       |---- ets
|                             |----MainAbility
|                                   |---- pages
|                                         |---- colorPickerUI.ets
|                                         |---- index.ets

```

## Compatibility
Supports OpenHarmony API version 8 or above

## Code Contribution

If you find any problems during usage, you can submit
an [Issue](https://github.com/Applib-OpenHarmony/ColorPicker/issues) to us. Of course, we also welcome you to
send us [PR](https://github.com/Applib-OpenHarmony/ColorPicker/pulls).

## Open source License

This project is based
on [Apache License 2.0](https://github.com/Applib-OpenHarmony/ColorPicker/blob/main/LICENSE), please enjoy and
participate in open source freely.

## Reference
Design by: [Ayush](https://github.com/AyushLM)
