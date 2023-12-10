# How to use

```dart
1. dart run json_model
// 注意在此步骤前，应该把model的错误的类型修改正确
2. dart run build_runner build
```

---

### `json_model`

将 `jsons/` 下的 `json` 文件转为 `model.dart`  
路径在 `/lib/models/`

### `json_serializable`&`build_runner`

将 `/lib/models/` 下的所有 `model` 类生成 `model.g.dart`  
此文件会附带 `fromJson` 以及 `toJson` 方法

---

> ### 引入时版本:
>
> > json_model: ^1.0.0  
> >  json_serializable: ^6.7.1  
> >  build_runner: ^2.4.6
