<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Doctrine\ORM\EntityManagerInterface;
use App\Entity\User;

class UserController extends AbstractController
{
    // Обрабатываем запросы для /api/register
    #[Route('/api/register', name: 'api_register', methods: ['POST', 'OPTIONS'])]
    public function register(Request $request, UserPasswordHasherInterface $passwordHasher, EntityManagerInterface $entityManager)
    {
        // Если это OPTIONS запрос, возвращаем успешный ответ для CORS
        if ($request->getMethod() === 'OPTIONS') {
            return new JsonResponse(null, JsonResponse::HTTP_OK);
        }

        // Обработка POST запроса на регистрацию пользователя
        $data = json_decode($request->getContent(), true);
        
        // Проверяем, что пришли нужные данные
        if (!isset($data['email']) || !isset($data['password'])) {
            return new JsonResponse(['error' => 'Email and password are required'], JsonResponse::HTTP_BAD_REQUEST);
        }

        // Создаем нового пользователя
        $user = new User();
        $user->setEmail($data['email']);
        $user->setPassword($passwordHasher->hashPassword($user, $data['password']));
        
        // Сохраняем пользователя в базе данных
        $entityManager->persist($user);
        $entityManager->flush();

        // Отправляем ответ об успешной регистрации
        return new JsonResponse(['status' => 'User registered'], JsonResponse::HTTP_CREATED);
    }

    // Обрабатываем запросы для /api/login
    #[Route('/api/login', name: 'api_login', methods: ['POST'])]
    public function login(Request $request, UserPasswordHasherInterface $passwordHasher, EntityManagerInterface $entityManager)
    {
        // Получаем данные из запроса
        $data = json_decode($request->getContent(), true);

        // Проверяем наличие email и password
        if (!isset($data['email']) || !isset($data['password'])) {
            return new JsonResponse(['error' => 'Email and password are required'], JsonResponse::HTTP_BAD_REQUEST);
        }

        // Ищем пользователя по email
        $user = $entityManager->getRepository(User::class)->findOneBy(['email' => $data['email']]);

        // Проверяем, существует ли пользователь и корректен ли пароль
        if (!$user || !$passwordHasher->isPasswordValid($user, $data['password'])) {
            return new JsonResponse(['error' => 'Invalid credentials'], JsonResponse::HTTP_UNAUTHORIZED);
        }

        // Генерируем токен (например, используя JWT или простой пример)
        return new JsonResponse(['token' => 'example-token']);
    }
}
