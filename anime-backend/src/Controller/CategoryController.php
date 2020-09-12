<?php


namespace App\Controller;


use App\AutoMapping;
use App\Request\CreateCategoryRequest;
use App\Request\DeleteRequest;
use App\Request\GetByIdRequest;
use App\Request\UpdateCategoryRequest;
use App\Service\CategoryService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class CategoryController extends BaseController
{
    private $categoryService;
    private $autoMapping;

    /**
     * CategoryController constructor.
     * @param CategoryService $categoryService
     * @param AutoMapping $autoMapping
     */
    public function __construct(CategoryService $categoryService, AutoMapping $autoMapping)
    {
        $this->categoryService = $categoryService;
        $this->autoMapping = $autoMapping;
    }

    /**
     * @Route("/category", name="createCategory", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, CreateCategoryRequest::class, (object) $data);
        $result = $this->categoryService->create($request);
        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/category", name="getAllCategories", methods={"GET"})
     */
    public function getAll()
    {
        $result = $this->categoryService->getAll();
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/category/{id}", name="getCategory", methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     */
    public function getById(Request $request)
    {
        $request=new GetByIdRequest($request->get('id'));
        $result = $this->categoryService->getCategoryById($request);
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/category", name="updateCategory", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse|Response
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        //$id = $request->get('id');
        $request = $this->autoMapping->map(\stdClass::class, UpdateCategoryRequest::class, (object) $data);
        //$request->setId($id);
        $result = $this->categoryService->update($request);
        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("/category/{id}", name="deleteCategory", methods={"DELETE"})
     * @param Request $request
     * @return JsonResponse
     */
    public function delete(Request $request)
    {
        $request = new DeleteRequest($request->get('id'));
        $result = $this->categoryService->delete($request);

        return $this->response($result, self::DELETE);
    }
}