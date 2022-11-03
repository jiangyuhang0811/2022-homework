int canvasLeftCornerX = 30;
int canvasLeftCornerY = 60;

void UI() {
  bar = new ControlP5(this, createFont("微软雅黑", 14));

  int barSize = 200;
  int barHeight = 20;
  int barInterval = barHeight + 10;

  bar.addSlider("sectionSideNum", 3, 16, 5, canvasLeftCornerX, canvasLeftCornerY, barSize, barHeight).setLabel("断面边数");
  bar.addSlider("sideDivision", 1, 50, 40, canvasLeftCornerX, canvasLeftCornerY+barInterval, barSize, barHeight).setLabel("断面边细分段数");
  bar.addSlider("cylinderHeightSection", 3, 200, 100, canvasLeftCornerX, canvasLeftCornerY+barInterval*2, barSize, barHeight).setLabel("柱体高度分段数");
  bar.addSlider("cylinderSectionHeight", 0, 100, 10, canvasLeftCornerX, canvasLeftCornerY+barInterval*3, barSize, barHeight).setLabel("柱体分段高度");
  bar.addSlider("sectionBaseRadius", 0, 500, 100, canvasLeftCornerX, canvasLeftCornerY+barInterval*4, barSize, barHeight).setLabel("柱体底面半径");
  bar.addSlider("colourRed", 0, 255, 255, canvasLeftCornerX, canvasLeftCornerY+barInterval*5, barSize, barHeight).setLabel("RGB颜色 R");
  bar.addSlider("colourGreen", 0, 255, 255, canvasLeftCornerX, canvasLeftCornerY+barInterval*6, barSize, barHeight).setLabel("RGB颜色 G");
  bar.addSlider("colourBlue", 0, 255, 255, canvasLeftCornerX, canvasLeftCornerY+barInterval*7, barSize, barHeight).setLabel("RGB颜色 B");
  bar.addSlider("sectionRadiusPhase", 0, PI*4, TWO_PI, canvasLeftCornerX, canvasLeftCornerY+barInterval*8, barSize, barHeight).setLabel("柱体半径相变");
  bar.addSlider("Amplitude", 0, 2, 0.5, canvasLeftCornerX, canvasLeftCornerY+barInterval*9, barSize, barHeight).setLabel("柱体半径相变振幅");
  bar.addSlider("twist", -PI*4, PI*4, TWO_PI, canvasLeftCornerX, canvasLeftCornerY+barInterval*10, barSize, barHeight).setLabel("柱体扭曲度");

  bar.setAutoDraw(false);
}

void lightSettings() {
  lightSpecular(255, 255, 255);
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(127, 127, 127, -1, -1, 1);
  specular(200, 200, 200);
  shininess(15);
}

void UIShow() {
  cam.beginHUD();  
  lights();
  bar.draw();
  cam.endHUD();

  if (mouseX<400 && mouseY< 390) {
    cam.setActive(false);
  } else {
    cam.setActive(true);
  }
}
