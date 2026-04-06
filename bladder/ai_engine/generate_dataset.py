import os
import cv2
import numpy as np
import random
from pathlib import Path

def generate_ultrasound_image(width=224, height=224, is_empty=True):
    # 1. Base tissue (dark grey with noise)
    base = np.ones((height, width), dtype=np.uint8) * 80
    noise = np.random.normal(0, 20, (height, width)).astype(np.float32)
    base = np.clip(base + noise, 0, 255).astype(np.uint8)
    
    # 2. Add ultrasound "cone" mask (fan shape typical of pelvic ultrasound)
    mask = np.zeros((height, width), dtype=np.float32)
    center = (width // 2, -20)
    axes = (width, int(height * 1.2))
    cv2.ellipse(mask, center, axes, 90, -45, 45, 1, -1)
    
    # Apply cone mask
    image = (base * mask).astype(np.uint8)
    
    # 3. Create the bladder (anechoic / black area)
    bladder_mask = np.zeros((height, width), dtype=np.float32)
    
    center_x = width // 2 + random.randint(-15, 15)
    center_y = int(height * 0.6) + random.randint(-20, 20)
    
    if is_empty:
        # Empty bladder: small, collapsed, irregular
        bw = random.randint(15, 30)
        bh = random.randint(5, 15)
        cv2.ellipse(bladder_mask, (center_x, center_y), (bw, bh), random.randint(-10, 10), 0, 360, 1, -1)
    else:
        # Filled bladder: large, rounded, balloon-like
        bw = random.randint(50, 80)
        bh = random.randint(40, 70)
        cv2.ellipse(bladder_mask, (center_x, center_y), (bw, bh), random.randint(-5, 5), 0, 360, 1, -1)
    
    # Soften edges of bladder
    bladder_mask = cv2.GaussianBlur(bladder_mask, (15, 15), 5)
    
    # Apply bladder to image (make the bladder area very dark)
    image = image * (1.0 - bladder_mask * 0.85)
    
    # 4. Add speckle noise characteristic of US
    speckle = np.random.exponential(1.2, (height, width))
    speckle = (speckle / np.max(speckle) * 40).astype(np.uint8)
    image = cv2.add(image.astype(np.uint8), speckle)
    
    # Extra blurring to look like US
    image = cv2.GaussianBlur(image, (3, 3), 1)
    
    return image.astype(np.uint8)

def main():
    base_dir = Path(__file__).parent.parent / "dataset"
    filled_dir = base_dir / "filled"
    empty_dir = base_dir / "empty"
    
    os.makedirs(filled_dir, exist_ok=True)
    os.makedirs(empty_dir, exist_ok=True)
    
    num_samples_per_class = 200
    
    print(f"Generating {num_samples_per_class} filled bladder images...")
    for i in range(num_samples_per_class):
        img = generate_ultrasound_image(is_empty=False)
        cv2.imwrite(str(filled_dir / f"syn_filled_{i:04d}.jpg"), img)
        
    print(f"Generating {num_samples_per_class} empty bladder images...")
    for i in range(num_samples_per_class):
        img = generate_ultrasound_image(is_empty=True)
        cv2.imwrite(str(empty_dir / f"syn_empty_{i:04d}.jpg"), img)
        
    print("Dataset generation complete!")

if __name__ == "__main__":
    main()
