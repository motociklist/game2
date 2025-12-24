import 'dart:io';
import 'package:image/image.dart' as img;

void main() async {
  // Создаем иконку 1024x1024
  final size = 1024;
  final image = img.Image(width: size, height: size);

  // Заливаем фон (голубой небо)
  final backgroundColor = img.ColorRgb8(74, 144, 226); // #4A90E2
  img.fill(image, color: backgroundColor);

  // Рисуем самолет (белый)
  final airplaneColor = img.ColorRgb8(255, 255, 255);
  final centerX = size ~/ 2;
  final centerY = size ~/ 2;

  // Корпус самолета (прямоугольник)
  final bodyWidth = size ~/ 3;
  final bodyHeight = size ~/ 8;
  img.fillRect(
    image,
    x1: centerX - bodyWidth ~/ 2,
    y1: centerY - bodyHeight ~/ 2,
    x2: centerX + bodyWidth ~/ 2,
    y2: centerY + bodyHeight ~/ 2,
    color: airplaneColor,
  );

  // Нос самолета (треугольник)
  final noseSize = size ~/ 6;
  final nosePoints = [
    img.Point(centerX + bodyWidth ~/ 2, centerY),
    img.Point(centerX + bodyWidth ~/ 2 + noseSize, centerY - noseSize ~/ 2),
    img.Point(centerX + bodyWidth ~/ 2 + noseSize, centerY + noseSize ~/ 2),
  ];
  img.fillPolygon(image, vertices: nosePoints, color: airplaneColor);

  // Крылья
  final wingWidth = size ~/ 4;
  final wingHeight = size ~/ 20;
  // Левое крыло
  img.fillRect(
    image,
    x1: centerX - bodyWidth ~/ 4,
    y1: centerY - bodyHeight ~/ 2 - wingHeight,
    x2: centerX - bodyWidth ~/ 4 - wingWidth,
    y2: centerY - bodyHeight ~/ 2,
    color: airplaneColor,
  );
  // Правое крыло
  img.fillRect(
    image,
    x1: centerX - bodyWidth ~/ 4,
    y1: centerY + bodyHeight ~/ 2,
    x2: centerX - bodyWidth ~/ 4 - wingWidth,
    y2: centerY + bodyHeight ~/ 2 + wingHeight,
    color: airplaneColor,
  );

  // Хвост
  final tailWidth = size ~/ 12;
  final tailHeight = size ~/ 3;
  img.fillRect(
    image,
    x1: centerX - bodyWidth ~/ 2 - tailWidth,
    y1: centerY - tailHeight ~/ 2,
    x2: centerX - bodyWidth ~/ 2,
    y2: centerY + tailHeight ~/ 2,
    color: airplaneColor,
  );

  // Сохраняем основную иконку
  final pngBytes = img.encodePng(image);
  final iconFile = File('assets/icon/airplane_icon.png');
  await iconFile.create(recursive: true);
  await iconFile.writeAsBytes(pngBytes);
  stdout.writeln('✓ Создана иконка: ${iconFile.path}');

  // Создаем иконку для adaptive icon (foreground)
  final foregroundImage = img.Image(width: size, height: size, numChannels: 4); // RGBA для прозрачности

  // Рисуем только самолет без фона
  img.fillRect(
    foregroundImage,
    x1: centerX - bodyWidth ~/ 2,
    y1: centerY - bodyHeight ~/ 2,
    x2: centerX + bodyWidth ~/ 2,
    y2: centerY + bodyHeight ~/ 2,
    color: airplaneColor,
  );

  final foregroundNosePoints = [
    img.Point(centerX + bodyWidth ~/ 2, centerY),
    img.Point(centerX + bodyWidth ~/ 2 + noseSize, centerY - noseSize ~/ 2),
    img.Point(centerX + bodyWidth ~/ 2 + noseSize, centerY + noseSize ~/ 2),
  ];
  img.fillPolygon(foregroundImage, vertices: foregroundNosePoints, color: airplaneColor);

  img.fillRect(
    foregroundImage,
    x1: centerX - bodyWidth ~/ 4,
    y1: centerY - bodyHeight ~/ 2 - wingHeight,
    x2: centerX - bodyWidth ~/ 4 - wingWidth,
    y2: centerY - bodyHeight ~/ 2,
    color: airplaneColor,
  );

  img.fillRect(
    foregroundImage,
    x1: centerX - bodyWidth ~/ 4,
    y1: centerY + bodyHeight ~/ 2,
    x2: centerX - bodyWidth ~/ 4 - wingWidth,
    y2: centerY + bodyHeight ~/ 2 + wingHeight,
    color: airplaneColor,
  );

  img.fillRect(
    foregroundImage,
    x1: centerX - bodyWidth ~/ 2 - tailWidth,
    y1: centerY - tailHeight ~/ 2,
    x2: centerX - bodyWidth ~/ 2,
    y2: centerY + tailHeight ~/ 2,
    color: airplaneColor,
  );

  final foregroundPngBytes = img.encodePng(foregroundImage);
  final foregroundFile = File('assets/icon/airplane_icon_foreground.png');
  await foregroundFile.writeAsBytes(foregroundPngBytes);
  stdout.writeln('✓ Создана иконка foreground: ${foregroundFile.path}');

  stdout.writeln('\n✓ Иконки успешно созданы!');
  stdout.writeln('Запустите: flutter pub run flutter_launcher_icons');
}

