import requests
from requests.auth import HTTPBasicAuth
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.viewsets import GenericViewSet
from rest_framework.mixins import CreateModelMixin, RetrieveModelMixin, UpdateModelMixin
from rest_framework.permissions import IsAuthenticated, AllowAny
from .models import User
from .serializers import CustomSerializer

class UserViewSet(CreateModelMixin, RetrieveModelMixin, UpdateModelMixin, GenericViewSet):
    queryset = User.objects.all()
    serializer_class = CustomSerializer
    permission_classes = [IsAuthenticated]

    def get_permissions(self):
        if self.request.method == 'GET':
            return [AllowAny()]
        return [IsAuthenticated()]

    @action(detail=False, methods=['GET', 'PUT'])
    def me(self, request):
        (user, _) = User.objects.get_or_create(user_id=request.user.id)
        history = requests.get(f'https://v3.api.hypertrack.com/devices/{user.device_id}/history/',
                                headers=HTTPBasicAuth('Pq7yA69XPsXZEfJ7CTVgYdpP800', 'BBLJspH9y5uYt0zQhP0L_mK24ZYYISkHra8bYSb_z4X-7pRqNctLAQ'))

        if request.method == 'GET':
            serializer = CustomSerializer(user)
            return Response(serializer.data)
        elif request.method == 'PUT':
            serializer = CustomSerializer(user, data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data)
        
