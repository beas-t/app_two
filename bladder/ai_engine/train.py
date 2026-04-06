import os
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import DataLoader
from torchvision import datasets, transforms
from pathlib import Path

# Local imports
from model import BladderClassifier

def train_model():
    print("Initializing Bladder Scan Training Pipeline...")
    
    # 1. Setup paths and device
    base_dir = Path(__file__).parent.parent / "dataset"
    if not os.path.exists(base_dir):
        print(f"Dataset directory not found at {base_dir}")
        print("Please run generate_dataset.py first or provide a real dataset.")
        return
        
    device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
    print(f"Using device: {device}")
    
    # 2. Define transforms (Resize, normalize for MobileNetV2)
    data_transforms = transforms.Compose([
        transforms.Resize(256),
        transforms.CenterCrop(224),
        transforms.ToTensor(),
        transforms.Normalize([0.485, 0.456, 0.406], [0.229, 0.224, 0.225])
    ])
    
    # 3. Load Dataset
    print(f"Loading data from {base_dir}...")
    image_dataset = datasets.ImageFolder(base_dir, data_transforms)
    class_names = image_dataset.classes
    print(f"Classes found: {class_names}")  # Expecting ['empty', 'filled']
    
    # Simple split (80% train, 20% val)
    train_size = int(0.8 * len(image_dataset))
    val_size = len(image_dataset) - train_size
    train_dataset, val_dataset = torch.utils.data.random_split(image_dataset, [train_size, val_size])
    
    dataloaders = {
        'train': DataLoader(train_dataset, batch_size=32, shuffle=True, num_workers=0),
        'val': DataLoader(val_dataset, batch_size=32, shuffle=False, num_workers=0)
    }
    dataset_sizes = {'train': len(train_dataset), 'val': len(val_dataset)}
    print(f"Dataset sizes: {dataset_sizes}")
    
    # 4. Initialize model, loss, optimizer
    model = BladderClassifier(num_classes=len(class_names))
    model = model.to(device)
    
    criterion = nn.CrossEntropyLoss()
    optimizer = optim.Adam(model.parameters(), lr=0.001)
    
    num_epochs = 5 # Small number for demonstration/synthetic data
    
    print("\nStarting Training Loop...")
    for epoch in range(num_epochs):
        print(f'Epoch {epoch+1}/{num_epochs}')
        print('-' * 10)
        
        for phase in ['train', 'val']:
            if phase == 'train':
                model.train()
            else:
                model.eval()
                
            running_loss = 0.0
            running_corrects = 0
            
            for inputs, labels in dataloaders[phase]:
                inputs = inputs.to(device)
                labels = labels.to(device)
                
                optimizer.zero_grad()
                
                with torch.set_grad_enabled(phase == 'train'):
                    outputs = model(inputs)
                    _, preds = torch.max(outputs, 1)
                    loss = criterion(outputs, labels)
                    
                    if phase == 'train':
                        loss.backward()
                        optimizer.step()
                        
                running_loss += loss.item() * inputs.size(0)
                running_corrects += torch.sum(preds == labels.data)
                
            epoch_loss = running_loss / dataset_sizes[phase]
            epoch_acc = running_corrects.double() / dataset_sizes[phase]
            
            print(f'{phase} Loss: {epoch_loss:.4f} Acc: {epoch_acc:.4f}')
            
    # 5. Save the trained model
    save_path = Path(__file__).parent / "bladder_model.pth"
    torch.save(model.state_dict(), save_path)
    print(f"Training complete. Model saved to {save_path}")

if __name__ == "__main__":
    train_model()
