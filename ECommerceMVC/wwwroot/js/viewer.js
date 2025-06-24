import * as THREE from 'https://cdn.jsdelivr.net/npm/three@0.177.0/build/three.module.js';
import { OrbitControls } from 'https://cdn.jsdelivr.net/npm/three@0.177.0/examples/jsm/controls/OrbitControls.js';
import { GLTFLoader } from 'https://cdn.jsdelivr.net/npm/three@0.177.0/examples/jsm/loaders/GLTFLoader.js';

console.log(" Module loaded");

let scene, camera, renderer, model, controls;
const modelPath = '/Model3D/chair01.gltf';

init();
animate();

function init() {
	const container = document.getElementById('modelViewer');
	if (!container) {
		console.error(" #modelViewer không tồn tại");
		return;
	}

	scene = new THREE.Scene();
	scene.background = new THREE.Color(0xf0f0f0);

	camera = new THREE.PerspectiveCamera(45, container.clientWidth / container.clientHeight, 0.1, 1000);
	camera.position.set(0, 2, 5);

	renderer = new THREE.WebGLRenderer({ antialias: true });
	renderer.setSize(container.clientWidth, container.clientHeight);
	container.appendChild(renderer.domElement);

	scene.add(new THREE.HemisphereLight(0xffffff, 0x444444, 1.5));

	controls = new OrbitControls(camera, renderer.domElement);

	const loader = new GLTFLoader();
	loader.load(modelPath, function (gltf) {
		model = gltf.scene;
		scene.add(model);
	}, undefined, function (error) {
		console.error("❌ Lỗi khi load GLTF:", error);
	});

	window.addEventListener('resize', () => {
		camera.aspect = container.clientWidth / container.clientHeight;
		camera.updateProjectionMatrix();
		renderer.setSize(container.clientWidth, container.clientHeight);
	});
}

function animate() {
	requestAnimationFrame(animate);
	if (model) model.rotation.y += 0.005;
	renderer.render(scene, camera);
}
