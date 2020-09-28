<?php


namespace App\Controller;


use App\AutoMapping;
use App\Request\CreateFollowRequest;
use App\Request\DeleteRequest;
use App\Service\FollowService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

class FollowController extends BaseController
{
    private $followService;
    private $autoMapping;

    /**
     * FollowController constructor.
     * @param FollowService $followService
     * @param AutoMapping $autoMapping
     */
    public function __construct(FollowService $followService, AutoMapping $autoMapping, SerializerInterface $serializer)
    {
        parent::__construct($serializer);
        $this->followService = $followService;
        $this->autoMapping = $autoMapping;
    }

    /**
     * @Route("/following", name="createFollowing", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, CreateFollowRequest::class, (object) $data);
        $result = $this->followService->create($request);
        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/following", name="getAllFollowing", methods={"GET"})
     */
    public function getAll()
    {
        $result = $this->followService->getAll();
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/following/{userID}", name="getFollowingById", methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     */
    public function getByUserId(Request $request)
    {
        $result = $this->followService->getFollowByUserId($request);
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/following/{id}", name="deleteFollowing", methods={"DELETE"})
     * @param Request $request
     * @return JsonResponse
     */
    public function delete(Request $request)
    {
        $request = new DeleteRequest($request->get('id'));
        $result = $this->followService->delete($request);

        return $this->response(" ", self::DELETE);
    }

    /**
     * @Route("/following/{userID}/{friendID}", name="deleteFollow", methods={"DELETE"})
     * @param Request $request
     * @return JsonResponse
     */
    public function deleteByUserIdAndFriendId(Request $request)
    {
        $result = $this->followService->deleteByUserIdAndFriendID($request);

        return $this->response(" ", self::DELETE);
    }
}