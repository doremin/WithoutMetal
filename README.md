# WithoutMetal

CPU 기반으로 동작하는 S/W Rendering Pipeline

## 🚀 소개

UIKit, Metal, OpenGL 없이도 3D 렌더링이 가능할까?
이 프로젝트는 GPU나 그래픽 라이브러리 없이, CPU만으로 직접 3D 그래픽 파이프라인을 구현한 실험적 렌더러입니다.

## 주요 구현 내용
- Image를 Frame Buffer로 활용
- Vertex Transform + Projection
모델 좌표를 화면 좌표로 직접 변환
- Z-buffer 기반 Depth 처리
삼각형 겹침에 대비한 depth 버퍼 구현
- Normal Vector 기반 조명 계산
Ambient + Diffuse 조명 모델 구현 (Phong 모델 확장 가능)
- Drag 인터랙션을 통한 회전 제어
UIKit의 GestureRecognizer로 모델 회전

## 🧠 배운 점

이 프로젝트의 목표는 다음을 직접 구현하면서 배우는 것이었습니다.
-	GPU 렌더링 파이프라인의 구조적 흐름
- 하나의 픽셀이 화면에 나오기 까지의 과정

![cube](/cube.gif)
