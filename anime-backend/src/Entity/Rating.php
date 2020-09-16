<?php

namespace App\Entity;

use App\Repository\RatingRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=RatingRepository::class)
 */
class Rating
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string")
     */
    private $userID;

    /**
     * @ORM\Column(type="integer")
     */
    private $animeID;

    /**
     * @ORM\Column(type="integer")
     */
    private $rateValue;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUserId(): ?int
    {
        return $this->userID;
    }

    public function setUserId(int $userID): self
    {
        $this->userID = $userID;

        return $this;
    }

    public function getAnimeId(): ?int
    {
        return $this->animeID;
    }

    public function setAnimeId(int $animeID): self
    {
        $this->animeID = $animeID;

        return $this;
    }

    public function getRateValue(): ?int
    {
        return $this->rateValue;
    }

    public function setRateValue(int $rateValue): self
    {
        $this->rateValue = $rateValue;

        return $this;
    }
}
