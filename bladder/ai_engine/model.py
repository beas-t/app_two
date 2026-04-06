import torch
import torch.nn as nn
import torchvision.models as models

class BladderClassifier(nn.Module):
    def __init__(self, num_classes=2):
        super(BladderClassifier, self).__init__()
        # Use a lightweight pre-trained model like MobileNetV2
        self.model = models.mobilenet_v2(weights=models.MobileNet_V2_Weights.IMAGENET1K_V1)
        
        # Replace the classifier head for binary classification
        in_features = self.model.classifier[1].in_features
        self.model.classifier = nn.Sequential(
            nn.Dropout(p=0.2),
            nn.Linear(in_features, num_classes)
        )
        
    def forward(self, x):
        return self.model(x)

def load_model(model_path, device='cpu'):
    model = BladderClassifier(num_classes=2)
    model.load_state_dict(torch.load(model_path, map_location=device))
    model.to(device)
    model.eval()
    return model
