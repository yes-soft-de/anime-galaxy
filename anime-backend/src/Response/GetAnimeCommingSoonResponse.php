<?php


namespace App\Response;


class GetAnimeCommingSoonResponse
{
    public $id;

    public $name;

    public $mainImage;
    
    public $categories = [];
    
    public $publishDate;
    
    public $posterImage;
    
    public $posterImageURL;
}